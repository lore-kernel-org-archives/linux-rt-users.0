From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: 3.12.9-rt13: BUG: soft lockup
Date: Thu, 13 Feb 2014 14:56:09 -0800
Message-ID: <52FD4D89.2000207@localhost>
References: <52FBF2F1.8040504@localhost> <alpine.DEB.2.02.1402132324230.21991@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1402132324230.21991@ionos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/13/2014 02:25 PM, Thomas Gleixner wrote:
> On Wed, 12 Feb 2014, Fernando Lopez-Lezcano wrote:
>> [771508.546449] RIP: 0010:[<ffffffff810dc60a>]  [<ffffffff810dc60a>]
>> smp_call_function_many+0x2ca/0x330
>
> Can you decode the exact location inside of smp_call_function_many via
> addr2line please ?

Hope this is useful (adding 0x2ce/0x330 as offsets does not make any 
difference, don't know if it should)...

# grep smp_call_function /var/log/messages|tail -1
Feb 12 14:18:21 cmn27 kernel: [771840.224419] RIP: 
0010:[<ffffffff810dc60e>]  [<ffffffff810dc60e>] 
smp_call_function_many+0x2ce/0x330
# addr2line -e 
/usr/lib/debug/lib/modules/3.12.10-300.rt15.1.fc20.ccrma.x86_64+rt/vmlinux 
  ffffffff810dc60e
/usr/src/debug/kernel-3.12.fc20.ccrma/linux-3.12.10-300.rt15.1.fc20.ccrma.x86_64/kernel/rtmutex.c:1295

This is the only time I was able to catch some logs of the problem (if 
it is the same). I had to revert to 3.10.27-rt25 for the time being and 
that seems to be holding up well so far.

-- Fernando
