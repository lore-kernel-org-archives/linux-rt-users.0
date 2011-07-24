From: hermann <brummer-@web.de>
Subject: Re: [ANNOUNCE] 3.0-rt3
Date: Sun, 24 Jul 2011 18:42:36 +0200
Message-ID: <1311525756.2276.6.camel@box>
References: <alpine.LFD.2.02.1107241223560.2702@ionos>
	 <4E2C2ED6.4040904@gmail.com>  <alpine.LFD.2.02.1107241807390.3136@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Maarten Lankhorst <m.b.lankhorst@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Darren Hart <dvhart@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1107241807390.3136@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

 schrieb Thomas Gleixner:

> Dear RT Folks,
> 
> I'm pleased to announce the 3.0-rt3 release.
> 
> Changes versus 3.0-rt2:
> 
>   * Fix earlyprintk really
> 

Hi

I still have some trouble with rt1 - rt3. 
During boot, the kernel is absolutely silent, sometimes it hangs on boot,
sometimes it hangs on login, sometimes it freeze without any known reason 
during session (no heavy load or some thing like that).
I cant find any meaningful log, so I just can report it as it is here.
rc7-rt0 works very well here, I build 3.0-rt1 - rt3 with the same config 
then rt0.

regards
hermann
