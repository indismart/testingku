

    Explore
    Gist
    Blog
    Help

    guhunderscore
    !

You don't have any verified emails. We recommend verifying at least one email.

Email verification will help our support team help you in case you have any email issues or lose your password.

    792
    1,027

public bigbluebutton / bigbluebutton

    Code
    Network
    Pull Requests 11
    Graphs

    Tags 9

    Files
    Commits
    Branches 72

bigbluebutton / bbb-api-demo / src / main / webapp / bbb_api.jsp
ffdixon an hour ago
Updates to bbb_api.jsp to pass along redirectClient=true for joinURL …

3 contributors
executable file 752 lines (619 sloc) 24.474 kb

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239
240
241
242
243
244
245
246
247
248
249
250
251
252
253
254
255
256
257
258
259
260
261
262
263
264
265
266
267
268
269
270
271
272
273
274
275
276
277
278
279
280
281
282
283
284
285
286
287
288
289
290
291
292
293
294
295
296
297
298
299
300
301
302
303
304
305
306
307
308
309
310
311
312
313
314
315
316
317
318
319
320
321
322
323
324
325
326
327
328
329
330
331
332
333
334
335
336
337
338
339
340
341
342
343
344
345
346
347
348
349
350
351
352
353
354
355
356
357
358
359
360
361
362
363
364
365
366
367
368
369
370
371
372
373
374
375
376
377
378
379
380
381
382
383
384
385
386
387
388
389
390
391
392
393
394
395
396
397
398
399
400
401
402
403
404
405
406
407
408
409
410
411
412
413
414
415
416
417
418
419
420
421
422
423
424
425
426
427
428
429
430
431
432
433
434
435
436
437
438
439
440
441
442
443
444
445
446
447
448
449
450
451
452
453
454
455
456
457
458
459
460
461
462
463
464
465
466
467
468
469
470
471
472
473
474
475
476
477
478
479
480
481
482
483
484
485
486
487
488
489
490
491
492
493
494
495
496
497
498
499
500
501
502
503
504
505
506
507
508
509
510
511
512
513
514
515
516
517
518
519
520
521
522
523
524
525
526
527
528
529
530
531
532
533
534
535
536
537
538
539
540
541
542
543
544
545
546
547
548
549
550
551
552
553
554
555
556
557
558
559
560
561
562
563
564
565
566
567
568
569
570
571
572
573
574
575
576
577
578
579
580
581
582
583
584
585
586
587
588
589
590
591
592
593
594
595
596
597
598
599
600
601
602
603
604
605
606
607
608
609
610
611
612
613
614
615
616
617
618
619
620
621
622
623
624
625
626
627
628
629
630
631
632
633
634
635
636
637
638
639
640
641
642
643
644
645
646
647
648
649
650
651
652
653
654
655
656
657
658
659
660
661
662
663
664
665
666
667
668
669
670
671
672
673
674
675
676
677
678
679
680
681
682
683
684
685
686
687
688
689
690
691
692
693
694
695
696
697
698
699
700
701
702
703
704
705
706
707
708
709
710
711
712
713
714
715
716
717
718
719
720
721
722
723
724
725
726
727
728
729
730
731
732
733
734
735
736
737
738
739
740
741
742
743
744
745
746
747
748
749
750
751

	

<%/**
* BigBlueButton open source conferencing system - http://www.bigbluebutton.org/
*
* Copyright (c) 2012 BigBlueButton Inc. and by respective authors (see below).
*
* This program is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free Software
* Foundation; either version 3.0 of the License, or (at your option) any later
* version.
*
* BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
* WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
* PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License along
* with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.
*
*/%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.xml.transform.dom.DOMSource"%>
<%@page import="javax.xml.transform.stream.StreamResult"%>
<%@page import="javax.xml.transform.OutputKeys"%>
<%@page import="javax.xml.transform.TransformerFactory"%>
<%@page import="javax.xml.transform.Transformer"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="com.sun.org.apache.xerces.internal.dom.ChildNode"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="java.util.*,java.io.*,java.net.*,javax.crypto.*,javax.xml.parsers.*,org.w3c.dom.Document,org.xml.sax.*" errorPage="error.jsp"%>

<%@ page import="org.apache.commons.codec.digest.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.nio.channels.FileChannel"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>

<%@ include file="bbb_api_conf.jsp"%>

<%!//
// Create a meeting with specific
// - meetingID
// - welcome message
// - moderator password
// - viewer password
// - voiceBridge
// - logoutURL
//
// Added for 0.8
//
// - metadata
// - xml (for pre-upload of slides)
//
public String createMeeting(String meetingID, String welcome, String moderatorPassword, String viewerPassword, Integer voiceBridge, String logoutURL) {
String base_url_create = BigBlueButtonURL + "api/create?";

String welcome_param = "";
String checksum = "";

String attendee_password_param = "&attendeePW=ap";
String moderator_password_param = "&moderatorPW=mp";
String voice_bridge_param = "";
String logoutURL_param = "";

if ((welcome != null) && !welcome.equals("")) {
welcome_param = "&welcome=" + urlEncode(welcome);
}

if ((moderatorPassword != null) && !moderatorPassword.equals("")) {
moderator_password_param = "&moderatorPW=" + urlEncode(moderatorPassword);
}

if ((viewerPassword != null) && !viewerPassword.equals("")) {
attendee_password_param = "&attendeePW=" + urlEncode(viewerPassword);
}

if ((voiceBridge != null) && voiceBridge > 0) {
voice_bridge_param = "&voiceBridge=" + urlEncode(voiceBridge.toString());
} else {
// No voice bridge number passed, so we'll generate a random one for this meeting
Random random = new Random();
Integer n = 70000 + random.nextInt(9999);
voice_bridge_param = "&voiceBridge=" + n;
}

if ((logoutURL != null) && !logoutURL.equals("")) {
logoutURL_param = "&logoutURL=" + urlEncode(logoutURL);
}

//
// Now create the URL
//

String create_parameters = "name=" + urlEncode(meetingID)
+ "&meetingID=" + urlEncode(meetingID) + welcome_param
+ attendee_password_param + moderator_password_param
+ voice_bridge_param + logoutURL_param;

Document doc = null;

try {
// Attempt to create a meeting using meetingID
String xml = getURL(base_url_create + create_parameters
+ "&checksum="
+ checksum("create" + create_parameters + salt));
doc = parseXml(xml);
} catch (Exception e) {
e.printStackTrace();
}

if (doc.getElementsByTagName("returncode").item(0).getTextContent().trim().equals("SUCCESS")) {
return meetingID;
}

return "Error "
+ doc.getElementsByTagName("messageKey").item(0).getTextContent().trim()
+ ": "
+ doc.getElementsByTagName("message").item(0).getTextContent()
.trim();
}

//
// getJoinMeetingURL() -- get join meeting URL for both viewer and moderator
//
public String getJoinMeetingURL(String username, String meetingID, String password, String clientURL) {
String base_url_join = BigBlueButtonURL + "api/join?";
        String clientURL_param = "";

if ((clientURL != null) && !clientURL.equals("")) {
clientURL_param = "&redirectClient=true&clientURL=" + urlEncode( clientURL );
}


String join_parameters = "meetingID=" + urlEncode(meetingID)
+ "&fullName=" + urlEncode(username) + "&password="
+ urlEncode(password) + clientURL_param;

return base_url_join + join_parameters + "&checksum="
+ checksum("join" + join_parameters + salt);
}




//
// Create a meeting and return a URL to join it as moderator. This is used for the API demos.
//
// Passed
// - username
// - meetingID
// - record ["true", "false"]
// - welcome message (null causes BigBlueButton to use the default welcome message
// - metadata (passed through when record="true"
// - xml (used for pre-upload of slides)_
//
// Returned
// - valid join URL using the username
//
// Note this meeting will use username for meetingID

public String getJoinURL(String username, String meetingID, String record, String welcome, Map<String, String> metadata, String xml) {
String base_url_create = BigBlueButtonURL + "api/create?";
String base_url_join = BigBlueButtonURL + "api/join?";

String welcome_param = "";
if ((welcome != null) && !welcome.equals("")) {
welcome_param = "&welcome=" + urlEncode(welcome);
}

String xml_param = "";
if ((xml != null) && !xml.equals("")) {
xml_param = xml;
}

Random random = new Random();
String voiceBridge_param = "&voiceBridge=" + (70000 + random.nextInt(9999));

//
// When creating a meeting, the 'name' parameter is the name of the meeting (not to be confused with
// the username). For example, the name could be "Fred's meeting" and the meetingID could be "ID-1234312".
//
// While name and meetingID should be different, we'll keep them the same. Why? Because calling api/create?
// with a previously used meetingID will return same meetingToken (regardless if the meeting is running or not).
//
// This means the first person to call getJoinURL with meetingID="Demo Meeting" will actually create the
// meeting. Subsequent calls will return the same meetingToken and thus subsequent users will join the same
// meeting.
//
// Note: We're hard-coding the password for moderator and attendee (viewer) for purposes of demo.
//

String create_parameters = "name=" + urlEncode(meetingID)
+ "&meetingID=" + urlEncode(meetingID) + welcome_param + voiceBridge_param
+ "&attendeePW=ap&moderatorPW=mp"
+ "&record=" + record + getMetaData( metadata );


// Attempt to create a meeting using meetingID
Document doc = null;
try {
String url = base_url_create + create_parameters
+ "&checksum="
+ checksum("create" + create_parameters + salt);
doc = parseXml( postURL( url, xml_param ) );
} catch (Exception e) {
e.printStackTrace();
}

if (doc.getElementsByTagName("returncode").item(0).getTextContent()
.trim().equals("SUCCESS")) {

//
// Looks good, now return a URL to join that meeting
//

String join_parameters = "meetingID=" + urlEncode(meetingID)
+ "&fullName=" + urlEncode(username) + "&password=mp";

return base_url_join + join_parameters + "&checksum="
+ checksum("join" + join_parameters + salt);
}

return doc.getElementsByTagName("messageKey").item(0).getTextContent()
.trim()
+ ": "
+ doc.getElementsByTagName("message").item(0).getTextContent()
.trim();
}

//
//Create a meeting and return a URL to join it as moderator
//
public String getJoinURLXML(String username, String meetingID, String welcome, String xml) {
String base_url_create = BigBlueButtonURL + "api/create?";
String base_url_join = BigBlueButtonURL + "api/join?";

String welcome_param = "";

Random random = new Random();
Integer voiceBridge = 70000 + random.nextInt(9999);

if ((welcome != null) && !welcome.equals("")) {
welcome_param = "&welcome=" + urlEncode(welcome);
}

        String xml_param = "";
        if ((xml != null) && !xml.equals("")) {
                xml_param = xml;
        }

String create_parameters = "name=" + urlEncode(meetingID)
+ "&meetingID=" + urlEncode(meetingID) + welcome_param
+ "&attendeePW=ap&moderatorPW=mp&voiceBridge=" + voiceBridge;

Document doc = null;

try {
// Attempt to create a meeting using meetingID
String params = postURL(base_url_create + create_parameters
+ "&checksum="
+ checksum("create" + create_parameters + salt), xml_param);
doc = parseXml(params);
} catch (Exception e) {
e.printStackTrace();
}

if (doc.getElementsByTagName("returncode").item(0).getTextContent()
.trim().equals("SUCCESS")) {

String join_parameters = "meetingID=" + urlEncode(meetingID)
+ "&fullName=" + urlEncode(username) + "&password=mp";

return base_url_join + join_parameters + "&checksum="
+ checksum("join" + join_parameters + salt);
}

return doc.getElementsByTagName("messageKey").item(0).getTextContent()
.trim()
+ ": "
+ doc.getElementsByTagName("message").item(0).getTextContent()
.trim();
}

//
// getJoinURLViewer() -- Get the URL to join a meeting as viewer
//
public String getJoinURLViewer(String username, String meetingID) {
String base_url_join = BigBlueButtonURL + "api/join?";
String join_parameters = "meetingID=" + urlEncode(meetingID)
+ "&fullName=" + urlEncode(username) + "&password=ap";

return base_url_join + join_parameters + "&checksum="
+ checksum("join" + join_parameters + salt);
}


//
// getURLisMeetingRunning() -- return a URL that the client can use to poll for whether the given meeting is running
//
public String getURLisMeetingRunning(String meetingID) {
String meetingParameters = "meetingID=" + urlEncode(meetingID);
return BigBlueButtonURL + "api/isMeetingRunning?" + meetingParameters
+ "&checksum="
+ checksum("isMeetingRunning" + meetingParameters + salt);	
}

//
// isMeetingRunning() -- check the BigBlueButton server to see if the meeting is running (i.e. there is someone in the meeting)
//
public String isMeetingRunning(String meetingID) {
Document doc = null;
try {
doc = parseXml( getURL( getURLisMeetingRunning(meetingID) ));
} catch (Exception e) {
e.printStackTrace();
}

if (doc.getElementsByTagName("returncode").item(0).getTextContent()
.trim().equals("SUCCESS")) {
return doc.getElementsByTagName("running").item(0).getTextContent()
.trim();
}

return "Error "
+ doc.getElementsByTagName("messageKey").item(0)
.getTextContent().trim()
+ ": "
+ doc.getElementsByTagName("message").item(0).getTextContent()
.trim();
}

public String getMeetingInfoURL(String meetingID, String password) {
String meetingParameters = "meetingID=" + urlEncode(meetingID)
+ "&password=" + password;
return BigBlueButtonURL + "api/getMeetingInfo?" + meetingParameters
+ "&checksum="
+ checksum("getMeetingInfo" + meetingParameters + salt);
}

public String getMeetingInfo(String meetingID, String password) {
try {
return getURL( getMeetingInfoURL(meetingID, password));
} catch (Exception e) {
e.printStackTrace(System.out);
return null;
}
}

public String getMeetingsURL() {
String meetingParameters = "random=" + new Random().nextInt(9999);
return BigBlueButtonURL + "api/getMeetings?" + meetingParameters
+ "&checksum="
+ checksum("getMeetings" + meetingParameters + salt);
}

//
// Calls getMeetings to obtain the list of meetings, then calls getMeetingInfo for each meeting
// and concatenates the result.
//
public String getMeetings() {
try {
        Document doc = parseXml( getURL( getMeetingsURL() ));

// tags needed for parsing xml documents
final String startTag = "<meetings>";
final String endTag = "</meetings>";
final String startResponse = "<response>";
final String endResponse = "</response>";

// if the request succeeded, then calculate the checksum of each meeting and insert it into the document
NodeList meetingsList = doc.getElementsByTagName("meeting");

String newXMldocument = startTag;
for (int i = 0; i < meetingsList.getLength(); i++) {
Element meeting = (Element) meetingsList.item(i);
String meetingID = meeting.getElementsByTagName("meetingID").item(0).getTextContent();
String password = meeting.getElementsByTagName("moderatorPW").item(0).getTextContent();

String data = getURL( getMeetingInfoURL(meetingID, password) );

if (data.indexOf("<response>") != -1) {
int startIndex = data.indexOf(startResponse) + startTag.length();
int endIndex = data.indexOf(endResponse);
newXMldocument += "<meeting>" + data.substring(startIndex, endIndex) + "</meeting>";
}
}
newXMldocument += endTag;

return newXMldocument;
} catch (Exception e) {
e.printStackTrace(System.out);
return null;
}
}



public String getendMeetingURL(String meetingID, String moderatorPassword) {
String end_parameters = "meetingID=" + urlEncode(meetingID) + "&password="
+ urlEncode(moderatorPassword);
return BigBlueButtonURL + "api/end?" + end_parameters + "&checksum="
+ checksum("end" + end_parameters + salt);
}

public String endMeeting(String meetingID, String moderatorPassword) {

Document doc = null;
try {
String xml = getURL(getendMeetingURL(meetingID, moderatorPassword));
doc = parseXml(xml);
} catch (Exception e) {
e.printStackTrace();
}

if (doc.getElementsByTagName("returncode").item(0).getTextContent()
.trim().equals("SUCCESS")) {
return "true";
}

return "Error "
+ doc.getElementsByTagName("messageKey").item(0)
.getTextContent().trim()
+ ": "
+ doc.getElementsByTagName("message").item(0).getTextContent()
.trim();
}


//////////////////////////////////////////////////////////////////////////////
//
// Added for BigBlueButton 0.8
//
//////////////////////////////////////////////////////////////////////////////

public String getRecordingsURL(String meetingID) {
String record_parameters = "meetingID=" + urlEncode(meetingID);
return BigBlueButtonURL + "api/getRecordings?" + record_parameters + "&checksum="
+ checksum("getRecordings" + record_parameters + salt);
}

public String getRecordings(String meetingID) {
//recordID,name,description,starttime,published,playback,length
String newXMLdoc = "<recordings>";

try {
Document doc = null;
String url = getRecordingsURL(meetingID);
doc = parseXml( getURL(url) );

// if the request succeeded, then calculate the checksum of each meeting and insert it into the document
NodeList recordingList = doc.getElementsByTagName("recording");


for (int i = 0; i < recordingList.getLength(); i++) {
Element recording = (Element) recordingList.item(i);

if(recording.getElementsByTagName("recordID").getLength()>0){

String recordID = recording.getElementsByTagName("recordID").item(0).getTextContent();
String name = recording.getElementsByTagName("name").item(0).getTextContent();
String description = "";
NodeList metadata = recording.getElementsByTagName("metadata");
if(metadata.getLength()>0){
Element metadataElem = (Element) metadata.item(0);
if(metadataElem.getElementsByTagName("description").getLength() > 0){
description = metadataElem.getElementsByTagName("description").item(0).getTextContent();
}
}

String starttime = recording.getElementsByTagName("startTime").item(0).getTextContent();
try{
SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
Date resultdate = new Date(Long.parseLong(starttime));
starttime = sdf.format(resultdate);
}catch(Exception e){

}
String published = recording.getElementsByTagName("published").item(0).getTextContent();
String playback = "";
String length = "";
NodeList formats = recording.getElementsByTagName("format");
for (int j = 0; j < formats.getLength(); j++){
Element format = (Element) formats.item(j);

String typeP = format.getElementsByTagName("type").item(0).getTextContent();
String urlP = format.getElementsByTagName("url").item(0).getTextContent();
String lengthP = format.getElementsByTagName("length").item(0).getTextContent();

if (j != 0){
playback +=", ";
}
playback += StringEscapeUtils.escapeXml("<a href='" + urlP + "' target='_blank'>" + typeP + "</a>");

if(typeP.equalsIgnoreCase("slides")){
length = lengthP;
}
}

newXMLdoc += "<recording>";

newXMLdoc += "<recordID>" + recordID + "</recordID>";
newXMLdoc += "<name><![CDATA[" + name + "]]></name>";
newXMLdoc += "<description><![CDATA[" + description + "]]></description>";
newXMLdoc += "<startTime>" + starttime + "</startTime>";
newXMLdoc += "<published>" + published + "</published>";
newXMLdoc += "<playback>" + playback + "</playback>";
newXMLdoc += "<length>" + length + "</length>";

newXMLdoc += "</recording>";
}
}
}catch (Exception e) {
e.printStackTrace(System.out);
return "error: "+e.getMessage();
}
newXMLdoc += "</recordings>";
return newXMLdoc;
}

public String getPublishRecordingsURL(boolean publish, String recordID) {
String publish_parameters = "recordID=" + urlEncode(recordID)
+ "&publish=" + publish;
return BigBlueButtonURL + "api/publishRecordings?" + publish_parameters + "&checksum="
+ checksum("publishRecordings" + publish_parameters + salt);
}

public String setPublishRecordings(boolean publish, String recordID){
try {
return getURL( getPublishRecordingsURL(publish,recordID));
} catch (Exception e) {
e.printStackTrace(System.out);
return null;
}
}

public String getDeleteRecordingsURL(String recordID) {
String delete_parameters = "recordID=" + urlEncode(recordID);
return BigBlueButtonURL + "api/deleteRecordings?" + delete_parameters + "&checksum="
+ checksum("deleteRecordings" + delete_parameters + salt);
}

public String deleteRecordings(String recordID){
try {
return getURL( getDeleteRecordingsURL(recordID));
} catch (Exception e) {
e.printStackTrace(System.out);
return null;
}
}



//////////////////////////////////////////////////////////////////////////////
//
// Helper Routines
//
//////////////////////////////////////////////////////////////////////////////

public String getMetaData( Map<String, String> metadata ) {
String metadata_params = "";

if ( metadata!=null ){
for(String metakey : metadata.keySet()){
metadata_params = metadata_params + "&meta_" + urlEncode(metakey) + "=" + urlEncode(metadata.get(metakey));
}
}

return metadata_params;
}

//
// checksum() -- create a hash based on the shared salt (located in bbb_api_conf.jsp)
//
public static String checksum(String s) {
String checksum = "";
try {
checksum = org.apache.commons.codec.digest.DigestUtils.shaHex(s);
} catch (Exception e) {
e.printStackTrace();
}
return checksum;
}

//
// getURL() -- fetch a URL and return its contents as a String
//
public static String getURL(String url) {
StringBuffer response = null;

try {
URL u = new URL(url);
HttpURLConnection httpConnection = (HttpURLConnection) u
.openConnection();

httpConnection.setUseCaches(false);
httpConnection.setDoOutput(true);
httpConnection.setRequestMethod("GET");

httpConnection.connect();
int responseCode = httpConnection.getResponseCode();
if (responseCode == HttpURLConnection.HTTP_OK) {
InputStream input = httpConnection.getInputStream();

// Read server's response.
response = new StringBuffer();
Reader reader = new InputStreamReader(input, "UTF-8");
reader = new BufferedReader(reader);
char[] buffer = new char[1024];
for (int n = 0; n >= 0;) {
n = reader.read(buffer, 0, buffer.length);
if (n > 0)
response.append(buffer, 0, n);
}

input.close();
httpConnection.disconnect();
}
} catch (Exception e) {
e.printStackTrace();
}

if (response != null) {
return response.toString();
} else {
return "";
}
}

public static String postURL(String targetURL, String urlParameters)
{
URL url;
HttpURLConnection connection = null;
int responseCode = 0;
try {
//Create connection
url = new URL(targetURL);
connection = (HttpURLConnection)url.openConnection();
connection.setRequestMethod("POST");
connection.setRequestProperty("Content-Type",
"text/xml");

connection.setRequestProperty("Content-Length", "" +
Integer.toString(urlParameters.getBytes().length));
connection.setRequestProperty("Content-Language", "en-US");

connection.setUseCaches (false);
connection.setDoInput(true);
connection.setDoOutput(true);

//Send request
DataOutputStream wr = new DataOutputStream (
connection.getOutputStream ());
wr.writeBytes (urlParameters);
wr.flush ();
wr.close ();

//Get Response
InputStream is = connection.getInputStream();
BufferedReader rd = new BufferedReader(new InputStreamReader(is));
String line;
StringBuffer response = new StringBuffer();
while((line = rd.readLine()) != null) {
response.append(line);
response.append('\r');
}
rd.close();
return response.toString();

} catch (Exception e) {

e.printStackTrace();
return null;

} finally {

if(connection != null) {
connection.disconnect();
}
}
}


//
// parseXml() -- return a DOM of the XML
//
public static Document parseXml(String xml)
throws ParserConfigurationException, IOException, SAXException {
DocumentBuilderFactory docFactory = DocumentBuilderFactory
.newInstance();
DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
Document doc = docBuilder.parse(new InputSource(new StringReader(xml)));
return doc;
}

//
// urlEncode() -- URL encode the string
//
public static String urlEncode(String s) {
try {
return URLEncoder.encode(s, "UTF-8");
} catch (Exception e) {
e.printStackTrace();
}
return "";
}

public String getMeetingsWithoutPasswords() {
try {
        Document doc = parseXml( getURL( getMeetingsURL() ));

// tags needed for parsing xml documents
final String startTag = "<meetings>";
final String endTag = "</meetings>";
final String startResponse = "<response>";
final String endResponse = "</response>";

// if the request succeeded, then calculate the checksum of each meeting and insert it into the document
NodeList meetingsList = doc.getElementsByTagName("meeting");

String newXMldocument = startTag;
for (int i = 0; i < meetingsList.getLength(); i++) {
Element meeting = (Element) meetingsList.item(i);
String meetingID = meeting.getElementsByTagName("meetingID").item(0).getTextContent();
String password = meeting.getElementsByTagName("moderatorPW").item(0).getTextContent();

String data = getURL( getMeetingInfoURL(meetingID, password) );

if (data.indexOf("<response>") != -1) {
data = removeTag(data, "<attendeePW>", "</attendeePW>");
data = removeTag(data, "<moderatorPW>", "</moderatorPW>");

int startIndex = data.indexOf(startResponse) + startResponse.length();
int endIndex = data.indexOf(endResponse);
newXMldocument += "<meeting>" + data.substring(startIndex, endIndex) + "</meeting>";
}
}
newXMldocument += endTag;

return newXMldocument;
} catch (Exception e) {
e.printStackTrace(System.out);
return null;
}
}

public static String removeTag(String data, String startTag, String endTag){
int startIndex = data.indexOf(startTag);
int endIndex = data.indexOf(endTag) + endTag.length();
String tagStr = data.substring(startIndex, endIndex);
return data.replace(tagStr,"");
}

%>



GitHub
    About us
    Blog
    Contact & support
    GitHub Enterprise
    Site status

Applications
    GitHub for Mac
    GitHub for Windows
    GitHub for Eclipse
    GitHub mobile apps

Services
    Gauges: Web analytics
    Speaker Deck: Presentations
    Gist: Code snippets
    Job board

Documentation
    GitHub Help
    Developer API
    GitHub Flavored Markdown
    GitHub Pages

More
    Training
    Students & teachers
    The Shop
    Plans & pricing
    The Octodex

© 2013 GitHub, Inc. All rights reserved.

    Terms of Service
    Privacy
    Security

