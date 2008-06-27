From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: [PATCH] Fix the processing of optional options for cyclictest
Date: Fri, 27 Jun 2008 16:34:03 +0200
Message-ID: <c384c5ea0806270734p73c68871k5dec8d1ad25afaff@mail.gmail.com>
References: <520f0cf10806270110l5b3199ablc936c38f4bcf24eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Steven Rostedt" <rostedt@goodmis.org>
To: "John Kacur" <jkacur@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:34581 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbYF0OeE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Jun 2008 10:34:04 -0400
Received: by an-out-0708.google.com with SMTP id d40so111024and.103
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Jun 2008 07:34:03 -0700 (PDT)
In-Reply-To: <520f0cf10806270110l5b3199ablc936c38f4bcf24eb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I still found it strange that the RTWiki mentions "-t NUM" as if it
works, so the manual page of cyclictest and the wiki needs a review
too.

I think I have access and will change this:

http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO

Figure 11. Benchmarking the Realtime Environment using Cyclictest

# ./cyclictest -p 80 -t 5 -n
1.58 1.61 1.62 3/68 4079

T: 0 ( 3131) P:80 I:    1000 C:16469865 Min:       8 Act:      13 Max: 62
T: 1 ( 3132) P:79 I:    1500 C: 9979903 Min:       8 Act:      18 Max: 75
T: 2 ( 3133) P:78 I:    2000 C: 7934887 Min:       9 Act:      22 Max: 83
T: 3 ( 3134) P:77 I:    2500 C: 6587910 Min:       9 Act:      25 Max: 81
T: 4 ( 3135) P:76 I:    3000 C: 5489925 Min:       9 Act:      27 Max: 86

Regards,
-- 
Leon
