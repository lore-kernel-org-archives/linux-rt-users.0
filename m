From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Tue, 08 Jan 2008 17:41:10 +0100
Message-ID: <4783A7A6.6030808@grandegger.com>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54706 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026AbYAHQlO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Jan 2008 11:41:14 -0500
In-Reply-To: <20080108154947.GB3177@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Robert Schwebel wrote:
> Hi Wolfgang,
> 
> On Tue, Jan 08, 2008 at 11:13:11AM +0100, Wolfgang Grandegger wrote:
>> I gave -rt another try on my Icecube-MPC5200 board with
>> patch-2.6.24-rc5-rt1
> 
> Unfortunately, I only have 2.6.23.1-rt5 for the phyCORE-MPC5200B-tiny (400 MHz)
> at the moment, but I can refactor it to match your version.

You are obviously using a 2.6.23.1 with private patches for MPC5200 as
there is no FEC driver or no clock event support in that version. The
_official_ 2.6.24-rc5 finally builds fine and works for my
Icecube-Eval-Board :-). Yes, it would make sense to add board support
for the phyCORE-MPC5200B-tiny for that version.

>> and this time I got it working with the attached little patch fixing
>> an oops in the serial driver. Unfortunately, cyclictest reports rather
>> high latencies up to 500 us under load:
> 
> Can you elaborate which load you are using?

"while ls; do ls; done" in a telnet window, "ping -f <host-ip>" and the
cache calibrator.

>> # ./cyclictest -n -p80 -t1 -i10000
>> 3.55 2.82 1.55 2/45 9971
>>
>> T: 0 (  922) P:80 I:10000 C: 64228 Min: 28 Act: 71 Avg: 78 Max: 502
> 
> This is on an idle system:
> 
> ----------8<----------
> root@phyCORE-MPC5200B-tiny:~ cyclictest -n -p80 -t1 -i10000 -l 64228
> 1.96 1.85 1.18 1/47 572          
> 
> T: 0 (  534) P:80 I:   10000 C:   64228 Min:      21 Act:      39 Avg:      38 Max:      77
> ----------8<----------
> 
> This is under ping -f load:
> 
> ----------8<----------
> root@phyCORE-MPC5200B-tiny:~ cyclictest -n -p80 -t1 -i10000 -l 64228
> 2.64 2.25 1.60 1/47 632
> 
> T: 0 (  594) P:80 I:   10000 C:   64228 Min:      24 Act:      41 Avg:      44 Max:      82
> ----------8<----------
> 
> And under "(while true; do hackbench 10; done) &" load:
> 
> ----------8<----------
> 367.51 329.66 189.94 7/449 4284
> 
> T: 0 ( 1439) P:80 I:   10000 C:   64228 Min:      28 Act:      48 Avg:      49 Max:      88
> ----------8<----------
> 
> Doesn't look too bad.

Some time in the past I also measured much better values and likely
there is a problem with the official version.

Wolfgang.
