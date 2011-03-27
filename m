From: =?ISO-8859-15?Q?Niccol=F2_Belli?= <darkbasic4@gmail.com>
Subject: My first recording session with a Focusrite Saffire PRO 40
Date: Sun, 27 Mar 2011 13:20:46 +0200
Message-ID: <4D8F1D8E.4010802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: ffado-user@lists.sourceforge.net,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49732 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab1C0LU4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 27 Mar 2011 07:20:56 -0400
Received: by wya21 with SMTP id 21so2154771wya.19
        for <linux-rt-users@vger.kernel.org>; Sun, 27 Mar 2011 04:20:55 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Yesterday I did my first session with my Saffire PRO 40, I initially
tried with kernel 2.6.33.7-rt30 and the old firewire stack, but I get
xruns even for a simple playback of a previously recorded session. I
also experienced lots of graphical problems because of the intel drivers
not playing well with old kernels. When I realized it was impossible to
record such a way I booted to a 2.6.38.1-bfq-ck1 I compiled for
recording purposes (Budget Fair Queueing I/O Scheduler, Brain Fuck
Scheduler and the whole Con Kolivas patchset with a 10.000 Hz timer
frequency). I obviously used the new firewire stack. This time it was
much better and I had no problems while playing a previously recorded
session. So I attached 8 analog inputs (two of them with inserts to
guitarix_head), another two inputs from Pianoteq and 10 outputs to
headphones for monitoring for a total of 10 inputs and 10 outputs.
I used hardware monitoring, with the only exceptions of the piano, the
guitar and the bass. Unfortunately even with a 17.4ms latency
(256/44100/3) I still got xruns and I had to restart the whole recording
lots of time because of that. My hardware isn't very powerful (a 1.4GHz
Core2 Duo ULV, 5400rpm serpent256 encrypted hard disk, 4GB ram) but I
think it can do much better, because I previously recorded without
problems with a Fast Track Ultra (USB) and 2.6.33-rt (when it wasn't a
useless, ancient kernel). Next time I will use a 3,3GHz quad core Sandy
Bridge 2500K with 8GB ram, I hope it will be enough :/

Cheers,
Darkbasic
