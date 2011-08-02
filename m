From: Mike Galbraith <mgalbraith@suse.de>
Subject: Re: [RFC][PATCH 0/3] update to cpupri algorithm
Date: Tue, 02 Aug 2011 10:46:07 +0200
Message-ID: <1312274767.15085.17.camel@marge.simson.net>
References: <20110729151340.419467771@goodmis.org>
	 <1312017596.8752.78.camel@marge.simson.net>
	 <1312208313.18583.28.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33017 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269Ab1HBJAg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Aug 2011 05:00:36 -0400
In-Reply-To: <1312208313.18583.28.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-08-01 at 10:18 -0400, Steven Rostedt wrote:

> Could you also post the results without the two cpupri patches?

ipc/timer patches still applied, cpupri patches popped.

During this 10 minute, 56 CPUs run, there were 230 events > 30us, max
+49.337, min -41.739.

T: 0 ( 8149) P:99 I:1000 C: 599001 Min:      1 Act:    2 Avg:    1 Max:      12
T: 1 ( 8150) P:99 I:1500 C: 399333 Min:      1 Act:    2 Avg:    1 Max:       5
T: 2 ( 8151) P:99 I:2000 C: 299498 Min:      1 Act:    2 Avg:    1 Max:       7
T: 3 ( 8152) P:99 I:2500 C: 239598 Min:      1 Act:    2 Avg:    1 Max:       4
T: 4 ( 8153) P:99 I:3000 C: 199664 Min:      1 Act:    1 Avg:    1 Max:       4
T: 5 ( 8154) P:99 I:3500 C: 171139 Min:      1 Act:    1 Avg:    1 Max:       5
T: 6 ( 8155) P:99 I:4000 C: 149746 Min:      1 Act:    1 Avg:    1 Max:       4
T: 7 ( 8156) P:99 I:4500 C: 133107 Min:      1 Act:    2 Avg:    1 Max:       4
T: 8 ( 8157) P:99 I:5000 C: 119796 Min:      2 Act:    3 Avg:    3 Max:      11
T: 9 ( 8158) P:99 I:5500 C: 108905 Min:      1 Act:    3 Avg:    2 Max:      14
T:10 ( 8159) P:99 I:6000 C:  99829 Min:      1 Act:    5 Avg:    2 Max:      13
T:11 ( 8160) P:99 I:6500 C:  92149 Min:      1 Act:    3 Avg:    2 Max:      10
T:12 ( 8161) P:99 I:7000 C:  85567 Min:      2 Act:    2 Avg:    2 Max:      11
T:13 ( 8162) P:99 I:7500 C:  79862 Min:      1 Act:    3 Avg:    2 Max:      12
T:14 ( 8163) P:99 I:8000 C:  74870 Min:      1 Act:    2 Avg:    2 Max:      11
T:15 ( 8164) P:99 I:8500 C:  70466 Min:      1 Act:    4 Avg:    2 Max:      15
T:16 ( 8165) P:99 I:9000 C:  66551 Min:      2 Act:    3 Avg:    3 Max:      16
T:17 ( 8166) P:99 I:9500 C:  63048 Min:      2 Act:    5 Avg:    3 Max:      15
T:18 ( 8167) P:99 I:10000 C:  59895 Min:      2 Act:    3 Avg:    3 Max:      12
T:19 ( 8168) P:99 I:10500 C:  57043 Min:      1 Act:    3 Avg:    3 Max:      10
T:20 ( 8169) P:99 I:11000 C:  54450 Min:      1 Act:    5 Avg:    3 Max:      15
T:21 ( 8170) P:99 I:11500 C:  52082 Min:      1 Act:    3 Avg:    3 Max:      10
T:22 ( 8171) P:99 I:12000 C:  49912 Min:      2 Act:    2 Avg:    3 Max:      11
T:23 ( 8172) P:99 I:12500 C:  47915 Min:      2 Act:    3 Avg:    3 Max:      10
T:24 ( 8173) P:99 I:13000 C:  46072 Min:      2 Act:    2 Avg:    3 Max:      11
T:25 ( 8174) P:99 I:13500 C:  44365 Min:      2 Act:    3 Avg:    3 Max:      12
T:26 ( 8175) P:99 I:14000 C:  42781 Min:      2 Act:    5 Avg:    4 Max:      12
T:27 ( 8176) P:99 I:14500 C:  41305 Min:      2 Act:    3 Avg:    3 Max:      11
T:28 ( 8177) P:99 I:15000 C:  39928 Min:      2 Act:    3 Avg:    3 Max:      11
T:29 ( 8178) P:99 I:15500 C:  38640 Min:      2 Act:    7 Avg:    3 Max:      12
T:30 ( 8179) P:99 I:16000 C:  37432 Min:      2 Act:    4 Avg:    4 Max:      14
T:31 ( 8180) P:99 I:16500 C:  36298 Min:      2 Act:    4 Avg:    3 Max:      14
T:32 ( 8181) P:99 I:17000 C:  35230 Min:      2 Act:    4 Avg:    3 Max:      10
T:33 ( 8182) P:99 I:17500 C:  34223 Min:      2 Act:    3 Avg:    3 Max:      11
T:34 ( 8183) P:99 I:18000 C:  33273 Min:      2 Act:    4 Avg:    3 Max:      10
T:35 ( 8184) P:99 I:18500 C:  32373 Min:      2 Act:    3 Avg:    3 Max:      10
T:36 ( 8185) P:99 I:19000 C:  31521 Min:      1 Act:    4 Avg:    3 Max:      10
T:37 ( 8186) P:99 I:19500 C:  30713 Min:      2 Act:    7 Avg:    3 Max:      12
T:38 ( 8187) P:99 I:20000 C:  29945 Min:      1 Act:    7 Avg:    6 Max:      11
T:39 ( 8188) P:99 I:20500 C:  29214 Min:      2 Act:    5 Avg:    3 Max:      11
T:40 ( 8189) P:99 I:21000 C:  28519 Min:      2 Act:    5 Avg:    4 Max:      14
T:41 ( 8190) P:99 I:21500 C:  27855 Min:      2 Act:    4 Avg:    3 Max:       9
T:42 ( 8191) P:99 I:22000 C:  27222 Min:      2 Act:    3 Avg:    3 Max:      10
T:43 ( 8192) P:99 I:22500 C:  26617 Min:      2 Act:    3 Avg:    3 Max:      15
T:44 ( 8193) P:99 I:23000 C:  26038 Min:      2 Act:    3 Avg:    3 Max:      11
T:45 ( 8194) P:99 I:23500 C:  25484 Min:      2 Act:    3 Avg:    3 Max:      13
T:46 ( 8195) P:99 I:24000 C:  24953 Min:      2 Act:    4 Avg:    3 Max:      10
T:47 ( 8196) P:99 I:24500 C:  24444 Min:      2 Act:    5 Avg:    3 Max:      11
T:48 ( 8197) P:99 I:25000 C:  23955 Min:      2 Act:    3 Avg:    3 Max:      11
T:49 ( 8198) P:99 I:25500 C:  23485 Min:      3 Act:    5 Avg:    5 Max:      15
T:50 ( 8199) P:99 I:26000 C:  23033 Min:      2 Act:    5 Avg:    3 Max:      12
T:51 ( 8200) P:99 I:26500 C:  22599 Min:      2 Act:    4 Avg:    3 Max:      12
T:52 ( 8201) P:99 I:27000 C:  22180 Min:      2 Act:    4 Avg:    3 Max:      10
T:53 ( 8202) P:99 I:27500 C:  21777 Min:      2 Act:    4 Avg:    3 Max:      11
T:54 ( 8203) P:99 I:28000 C:  21388 Min:      2 Act:    3 Avg:    3 Max:      11
T:55 ( 8204) P:99 I:28500 C:  21012 Min:      2 Act:    4 Avg:    3 Max:      11
T:56 ( 8205) P:99 I:29000 C:  20650 Min:      2 Act:    4 Avg:    3 Max:      10
T:57 ( 8206) P:99 I:29500 C:  20300 Min:      2 Act:    4 Avg:    3 Max:      11
T:58 ( 8207) P:99 I:30000 C:  19961 Min:      2 Act:    2 Avg:    3 Max:      10
T:59 ( 8208) P:99 I:30500 C:  19634 Min:      2 Act:    4 Avg:    3 Max:      11
T:60 ( 8209) P:99 I:31000 C:  19317 Min:      2 Act:    4 Avg:    3 Max:      15
T:61 ( 8210) P:99 I:31500 C:  19011 Min:      2 Act:    4 Avg:    3 Max:      10
T:62 ( 8211) P:99 I:32000 C:  18713 Min:      2 Act:    2 Avg:    2 Max:      10
T:63 ( 8212) P:99 I:32500 C:  18425 Min:      2 Act:    3 Avg:    2 Max:      12

Hrmph, hiccups don't show up in cyclictest numbers.

Repeating same exact test with folded patch re-applied..

T: 0 (12130) P:99 I:1000 C: 599001 Min:      1 Act:    2 Avg:    1 Max:       6
T: 1 (12131) P:99 I:1500 C: 399333 Min:      1 Act:    1 Avg:    1 Max:       5
T: 2 (12132) P:99 I:2000 C: 299498 Min:      1 Act:    1 Avg:    1 Max:       4
T: 3 (12133) P:99 I:2500 C: 239598 Min:      1 Act:    2 Avg:    1 Max:       4
T: 4 (12134) P:99 I:3000 C: 199664 Min:      1 Act:    1 Avg:    1 Max:       4
T: 5 (12135) P:99 I:3500 C: 171139 Min:      1 Act:    1 Avg:    1 Max:       4
T: 6 (12136) P:99 I:4000 C: 149746 Min:      1 Act:    2 Avg:    1 Max:       4
T: 7 (12137) P:99 I:4500 C: 133107 Min:      1 Act:    1 Avg:    1 Max:       5
T: 8 (12138) P:99 I:5000 C: 119796 Min:      1 Act:    4 Avg:    2 Max:       6
T: 9 (12139) P:99 I:5500 C: 108905 Min:      1 Act:    3 Avg:    2 Max:       6
T:10 (12140) P:99 I:6000 C:  99829 Min:      1 Act:    2 Avg:    2 Max:       6
T:11 (12141) P:99 I:6500 C:  92149 Min:      1 Act:    2 Avg:    2 Max:       7
T:12 (12142) P:99 I:7000 C:  85567 Min:      1 Act:    3 Avg:    2 Max:       5
T:13 (12143) P:99 I:7500 C:  79862 Min:      1 Act:    3 Avg:    2 Max:       8
T:14 (12144) P:99 I:8000 C:  74870 Min:      1 Act:    2 Avg:    2 Max:       5
T:15 (12145) P:99 I:8500 C:  70466 Min:      1 Act:    2 Avg:    2 Max:      11
T:16 (12146) P:99 I:9000 C:  66551 Min:      1 Act:    3 Avg:    2 Max:       6
T:17 (12147) P:99 I:9500 C:  63048 Min:      1 Act:    2 Avg:    2 Max:       6
T:18 (12148) P:99 I:10000 C:  59895 Min:      2 Act:    4 Avg:    3 Max:       7
T:19 (12149) P:99 I:10500 C:  57043 Min:      1 Act:    3 Avg:    2 Max:       5
T:20 (12150) P:99 I:11000 C:  54450 Min:      1 Act:    3 Avg:    2 Max:       5
T:21 (12151) P:99 I:11500 C:  52082 Min:      1 Act:    3 Avg:    2 Max:       5
T:22 (12152) P:99 I:12000 C:  49912 Min:      1 Act:    3 Avg:    2 Max:       6
T:23 (12153) P:99 I:12500 C:  47915 Min:      1 Act:    2 Avg:    2 Max:       5
T:24 (12154) P:99 I:13000 C:  46072 Min:      2 Act:    4 Avg:    3 Max:       8
T:25 (12155) P:99 I:13500 C:  44365 Min:      1 Act:    3 Avg:    3 Max:       5
T:26 (12156) P:99 I:14000 C:  42781 Min:      2 Act:    3 Avg:    2 Max:       6
T:27 (12157) P:99 I:14500 C:  41305 Min:      2 Act:    3 Avg:    3 Max:       6
T:28 (12158) P:99 I:15000 C:  39928 Min:      1 Act:    3 Avg:    2 Max:       6
T:29 (12159) P:99 I:15500 C:  38640 Min:      2 Act:    3 Avg:    3 Max:       6
T:30 (12160) P:99 I:16000 C:  37432 Min:      1 Act:    3 Avg:    2 Max:       5
T:31 (12161) P:99 I:16500 C:  36298 Min:      1 Act:    3 Avg:    3 Max:       7
T:32 (12162) P:99 I:17000 C:  35230 Min:      2 Act:    4 Avg:    3 Max:       8
T:33 (12163) P:99 I:17500 C:  34223 Min:      2 Act:    4 Avg:    3 Max:       8
T:34 (12164) P:99 I:18000 C:  33273 Min:      2 Act:    4 Avg:    3 Max:       8
T:35 (12165) P:99 I:18500 C:  32373 Min:      1 Act:    3 Avg:    3 Max:       9
T:36 (12166) P:99 I:19000 C:  31521 Min:      2 Act:    3 Avg:    3 Max:       7
T:37 (12167) P:99 I:19500 C:  30713 Min:      1 Act:    3 Avg:    2 Max:       6
T:38 (12168) P:99 I:20000 C:  29945 Min:      1 Act:    3 Avg:    2 Max:       6
T:39 (12169) P:99 I:20500 C:  29214 Min:      1 Act:    4 Avg:    2 Max:       8
T:40 (12170) P:99 I:21000 C:  28519 Min:      1 Act:    3 Avg:    2 Max:       7
T:41 (12171) P:99 I:21500 C:  27855 Min:      1 Act:    3 Avg:    2 Max:       6
T:42 (12172) P:99 I:22000 C:  27222 Min:      1 Act:    3 Avg:    2 Max:       9
T:43 (12173) P:99 I:22500 C:  26617 Min:      1 Act:    4 Avg:    2 Max:       5
T:44 (12174) P:99 I:23000 C:  26038 Min:      1 Act:    3 Avg:    2 Max:       7
T:45 (12175) P:99 I:23500 C:  25484 Min:      1 Act:    3 Avg:    2 Max:       8
T:46 (12176) P:99 I:24000 C:  24953 Min:      1 Act:    3 Avg:    2 Max:       7
T:47 (12177) P:99 I:24500 C:  24444 Min:      1 Act:    2 Avg:    3 Max:       5
T:48 (12178) P:99 I:25000 C:  23955 Min:      1 Act:    3 Avg:    2 Max:       6
T:49 (12179) P:99 I:25500 C:  23485 Min:      2 Act:    3 Avg:    2 Max:       7
T:50 (12180) P:99 I:26000 C:  23033 Min:      1 Act:    2 Avg:    2 Max:       5
T:51 (12181) P:99 I:26500 C:  22599 Min:      1 Act:    3 Avg:    2 Max:       5
T:52 (12182) P:99 I:27000 C:  22180 Min:      1 Act:    3 Avg:    2 Max:       6
T:53 (12183) P:99 I:27500 C:  21777 Min:      1 Act:    3 Avg:    2 Max:       5
T:54 (12184) P:99 I:28000 C:  21388 Min:      1 Act:    3 Avg:    2 Max:       6
T:55 (12185) P:99 I:28500 C:  21012 Min:      1 Act:    4 Avg:    2 Max:       8
T:56 (12186) P:99 I:29000 C:  20650 Min:      1 Act:    3 Avg:    2 Max:       6
T:57 (12187) P:99 I:29500 C:  20300 Min:      2 Act:    3 Avg:    2 Max:       6
T:58 (12188) P:99 I:30000 C:  19961 Min:      1 Act:    3 Avg:    2 Max:       6
T:59 (12189) P:99 I:30500 C:  19634 Min:      1 Act:    3 Avg:    3 Max:       7
T:60 (12190) P:99 I:31000 C:  19317 Min:      2 Act:    3 Avg:    2 Max:       7
T:61 (12191) P:99 I:31500 C:  19011 Min:      2 Act:    3 Avg:    2 Max:       7
T:62 (12192) P:99 I:32000 C:  18713 Min:      2 Act:    3 Avg:    2 Max:       5
T:63 (12193) P:99 I:32500 C:  18425 Min:      1 Act:    3 Avg:    2 Max:       5

No hiccups after startup, zero, nada.  Whatever.  Cyclictest is happier,
jitter test is finally a happy camper, so I'm a happy camper too.

	-Mike

