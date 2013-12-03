From: Daniel Wagner <wagi@monom.org>
Subject: HOWTO: Build an RT-application
Date: Tue, 03 Dec 2013 13:58:17 +0100
Message-ID: <529DD569.2080700@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Remy_B=F6hmer?= <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hotel311.server4you.de ([85.25.146.15]:51955 "EHLO
	hotel311.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab3LCM6T (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Dec 2013 07:58:19 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Remy,

I'd like to update "HOWTO: Build an RT-application" page on
the rt wiki[1]. Since your are listed as maintainer, I better
ask if my ideas are okay before editing.

1) I would like to get rid of quite outdated information (maybe
    move it to archive section?) on 'The impact of the Big Kernel Lock'
2) Add 'Don't use priority 99'
3) Don't implement spin locks (use priority inheritance futexes)
4) Avoid slow I/O
5) mmap passing data
6) Be aware of power management: cpufreq, nohz

2) - 5) are stolen from Steven's presentation

cheers,
daniel

[1] https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application
[2] http://elinux.org/images/b/ba/Elc2013_Rostedt.pdf
