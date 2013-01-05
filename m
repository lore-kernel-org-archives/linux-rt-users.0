From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Sat, 5 Jan 2013 05:09:46 +0100
Message-ID: <20130105040946.GA17645@netboy.at.omicron.at>
References: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com>
 <alpine.LFD.2.02.1210311949400.2756@ionos>
 <OF0AC62D08.8289F39F-ON86257AB7.0067DE83-86257AB7.006AEF36@ni.com>
 <50A55664.2090605@us.ibm.com>
 <OF701783A6.DD321DA8-ON86257AD9.0065C5C7-86257AD9.0071DB52@ni.com>
 <50D22A41.2070503@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scot Salmon <scot.salmon@ni.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: John Stultz <john.stultz@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:34056 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab3AEEJ5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Jan 2013 23:09:57 -0500
Received: by mail-ee0-f43.google.com with SMTP id e49so8518389eek.2
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Jan 2013 20:09:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50D22A41.2070503@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Instead of looking for new system calls, why not just solve this
problem at the application level?

1. boot machine
2. start ptp4l
3. wait five seconds
4. start control app, and just use clock_realtime

HTH,
Richard
