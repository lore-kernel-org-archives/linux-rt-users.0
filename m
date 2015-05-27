From: Warter <warter@gmail.com>
Subject: Re: Full RT kernel problem on arm
Date: Wed, 27 May 2015 19:25:35 +0200
Message-ID: <CAOn_9a4_CSEZb_fVVFRev+n4cT2CQKNLrgqaguMaRVaPSZ7zLQ@mail.gmail.com>
References: <CAOn_9a4vX9ixCJ-ZyhbjTAsghrH4UYW-UzWug3kKaUZvw5WUDA@mail.gmail.com>
	<55656DEA.4040006@monom.org>
	<CAOn_9a7_Dkq10nTcA6_GguzU-xt=XGztFBd1+=87GO7FCXqV_Q@mail.gmail.com>
	<5565A814.1090208@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37462 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbbE0RZg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 May 2015 13:25:36 -0400
Received: by wifw1 with SMTP id w1so31256899wif.0
        for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2015 10:25:35 -0700 (PDT)
In-Reply-To: <5565A814.1090208@monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I collected some logs I hope it helps.

mpd.log:

May 27 19:13 : client: [29] opened from 127.0.0.1:37393
May 27 19:13 : client: [29] closed
May 27 19:13 : client: [12] process command "next"
May 27 19:13 : playlist: play 1:"NAS/first.flac"
May 27 19:13 : player: played "NAS/second.flac"
May 27 19:13 : playlist: queue song 1:"NAS/third.flac"
May 27 19:13 : client: [12] command returned 0
May 27 19:13 : client: [27] process command "status"
May 27 19:13 : client: [27] command returned 0
May 27 19:13 : client: [27] process command "playlistinfo 5"
May 27 19:13 : client: [27] command returned 0
May 27 19:13 : client: [27] process command "close"
May 27 19:13 : client: [27] command returned 3
May 27 19:13 : client: [27] closed
May 27 19:13 : client: [12] process command "status"
May 27 19:13 : client: [12] command returned 0
May 27 19:13 : client: [12] process command "plchangesposid "14""
May 27 19:13 : client: [12] command returned 0
May 27 19:13 : client: [13] process command "idle"
May 27 19:13 : client: [13] command returned 1
May 27 19:13 : client: [12] process command "currentsong"
May 27 19:13 : client: [12] command returned 0
May 27 19:13 : decoder_thread: probing plugin flac
May 27 19:13 : decoder: audio_format=44100:16:2, seekable=true
May 27 19:13 : client: [30] opened from 127.0.0.1:37400
May 27 19:13 : client: [31] opened from 127.0.0.1:37402
May 27 19:13 : client: [30] process command "status"

w:
 19:13:19 up 2 min,  2 users,  load average: 0.75, 0.23, 0.09
 19:13:50 up 2 min,  2 users,  load average: 3.21, 0.87, 0.31
 19:14:55 up 3 min,  2 users,  load average: 5.72, 2.07, 0.76
 19:15:48 up 4 min,  2 users,  load average: 6.49, 2.90, 1.12
 19:18:28 up 7 min,  2 users,  load average: 6.21, 4.35, 1.96
 19:20:01 up 8 min,  2 users,  load average: 6.05, 4.78, 2.33

ps:
mpd       1875  0.4  7.4 124636 76696 ?        SLsl 19:11   0:01
/usr/bin/mpd --verbose /etc/mpd.conf

after kill:
mpd       1875  0.3  0.0      0     0 ?        Zsl  19:11   0:01 [mpd] <defunct>

It is interesting because if I use "Basic RT", there is no problem.

Thanks,
Szilard
