From: Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT v2] futex/rtmutex: Cure RT double blocking issue
Date: Thu, 11 May 2017 18:05:23 +0200
Message-ID: <20170511160523.ymdx4yhwatkwhq7v@linutronix.de>
References: <alpine.DEB.2.20.1705091707180.1798@nanos>
 <CANRm+Cx9msxF2jVsW6ZSXp5+u+L8yKq_KjcwBm5Bm=HLsvCK8w@mail.gmail.com>
 <alpine.DEB.2.20.1705110931240.1758@nanos>
 <20170511152054.bpgik7etss7umxzq@linutronix.de>
 <20170511115447.7622712d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Engleder Gerhard <eg@keba.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170511115447.7622712d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-05-11 11:54:47 [-0400], Steven Rostedt wrote:
> This is the same patch that Thomas wrote, right? Shouldn't this start
> with:
> 
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> ?

correct. It made its way properly into the patch queue, I just managed
to get it wrong while sending it to the list…

> -- Steve

Sebastian
