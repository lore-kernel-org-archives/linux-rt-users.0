From: Scot Salmon <scot.salmon@ni.com>
Subject: Re: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Wed, 23 Jan 2013 09:14:35 -0600
Message-ID: <OF3ADCA87F.2AD51296-ON86257AFA.006D68CF-86257AFC.0053BC00@ni.com>
References: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com> <alpine.LFD.2.02.1210311949400.2756@ionos> <OF0AC62D08.8289F39F-ON86257AB7.0067DE83-86257AB7.006AEF36@ni.com> <50A55664.2090605@us.ibm.com> <OF701783A6.DD321DA8-ON86257AD9.0065C5C7-86257AD9.0071DB52@ni.com> <50D22A41.2070503@linaro.org> <20130105040946.GA17645@netboy.at.omicron.at> <OF48F68A41.A33D8F99-ON86257AFA.0053184D-86257AFA.0055C08D@ni.com> <20130121191228.GE2342@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: John Stultz <john.stultz@linaro.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	linux-rt-users-owner@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver5.natinst.com ([130.164.80.5]:34922 "EHLO
	spamkiller05.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220Ab3AWPxl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Jan 2013 10:53:41 -0500
In-Reply-To: <20130121191228.GE2342@netboy.at.omicron.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Richard-

Skipping to the punch line, that worked for us. Thanks again.

Details:

> I still think that your problems can be solved at the application
> level quite easily. Just out of curiosity, I wrote a little test
> program, below, and I think it shows a promising direction to solve
> your issue. (The 'clk_cmp' function was taken from the userland servo
> in the phc2sys program, from the linuxptp project.)
...
> Running on my dinky atom netbook (32 bit, no vdso, no RT) in an
> unscientific test, I see the value of 'expected - offset' typically
> around a few hundred nanoseconds, with occasional outliers of a few
> microseconds. With RT-PREMPT these could surely be avoided...

I tried your code on a 667MHz ARM Cortex-A9 RT patched system and the 
initial results looked good.  I made a few tweaks to make the test a 
little more aggressive, changing the period to something faster and 
not-round so that it would be more likely to conflict with periodic 
interrupts, changing the reporting so that it only tells me when the delta 
got worse so that the spam from the faster rate is manageable, and setting 
it to run at an RT priority appropriate for our applications (without the 
RT priority, the results were predictably very bad under load, like 180us 
of variation).  Then I ran it under some load (gzip'ing two large files to 
load both cores, then scp'ing another large file to hit the network 
interrupt).  I saw a few readings more than 10us from the expected value 
which concerned me at first.  But, I think this turns out to be okay, as 
you predicted:

> ...using a moving average of say, 10 readings.
> 
> Also, rather than jumping to the new phase angle (if that is what you
> want in fact to do), you could smoothly ajust the loop phase using a
> PI controller or similar.

I talked to the guys who actually use the data I'm providing here, and 
they already do what you suggest, and figure that the occasional spike I 
reported is acceptable for that reason.  They also like the fact that the 
user mode solution would work on older kernels where the syscall would not 
be available.

I also noticed later that the 2nd...n'th readings after the nanosleep are 
consistently much better than the first one, i.e. n_readings of at least 2 
gives a perhaps-surprising improvement in the results.  The 1st offset 
reading is consistently low, i.e. with n_readings = 1, expected - offset 
is almost always positive.  This may be because of a first-iteration cache 
miss in the gettime(MONO) code path, and is mitigated either by using 
n_readings = 2 or adding a dummy gettime(MONO) before clk_cmp.

It still makes me itch a little to use an approximation when the exact 
value is tantalizingly close, but all things considered your user mode 
solution is the right answer.  Thank you very much for the idea, the demo, 
and all the patient advice.

John had mentioned earlier in the thread, regarding clock_gettime2:
> Yea, there's been a few times that folks have brought up the need, and 
> this sort of interface is probably the best way to go.

I'd be interested to know more about the other needs.  Ultimately if 
gettime2 is still useful and worth adding anyway, then I'd use it, so I 
can still pursue it if others think it's worthwhile for uses not covered 
by Richard's solution.

-Scot
