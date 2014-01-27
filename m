From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [ANNOUNCE] 3.12.8-rt11
Date: Mon, 27 Jan 2014 05:54:31 +0100
Message-ID: <52E5E687.1090808@osadl.org>
References: <20140125134519.GA9845@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140125134519.GA9845@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 01/25/2014 02:45 PM, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v3.12.8-rt11 patch set.
> [..]
Thanks a lot, Sebastian, excellent work!

I have upgraded about 40 different QA Farm systems (x86: 32-bit, 64-bit, 
single-core, multi-core 2 to 32, single-socket, dual-socket; ARM: 
single-core, multi-core), and they all boot and run without any problem. 
I didn't see any crash of unknown origin so far. Most systems use the 
original kernel besides some unimportant farm patches. Several systems 
have a worst-case latency below 20 microseconds (e.g. 
https://www.osadl.org/?id=1420 and https://www.osadl.org/?id=1805). Even 
Raspberry Pi and BeagleBone-Black work like a charm and have reasonably 
low real-time latency (https://www.osadl.org/?id=1663 and 
https://www.osadl.org/?id=1601), although they still are not 100% 
mainline. It is well conceivable that this or one of the next 3.12.X-rtY 
versions will remind us of the legendary 2.6.33 RT kernel.

Seems that an important milestone is being reached.

Thanks,
	-Carsten.
