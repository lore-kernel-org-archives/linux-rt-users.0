From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [v4.14-rt][report] arm: run: stress-ng --class os --all 0 -t 5m
Date: Tue, 19 Dec 2017 10:28:39 -0500
Message-ID: <20171219102839.367fa92d@gandalf.local.home>
References: <e421665a-8438-a1c0-4516-1b23dc758fc8@ti.com>
        <20171219082739.d6oxzkjkdicfu3hq@linutronix.de>
        <20171219100202.3017a79f@gandalf.local.home>
        <20171219150418.vz6hkpf4uuangb4q@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171219150418.vz6hkpf4uuangb4q@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 19 Dec 2017 16:04:18 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > 
> > The above just seems wrong. local_irq_disable() should imply
> > local_bh_disable(), as it doesn't let softirqs run either.  
> 
> Where does local_irq_disable() imply this?

If it doesn't explicitly do so, it probably should. How can we have a
softirq execute when irqs are disabled?

-- Steve
