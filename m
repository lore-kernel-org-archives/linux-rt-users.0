From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v4.9-rt][report] stress-ng: possible circular locking
 dependency detected
Date: Tue, 19 Dec 2017 09:39:49 +0100
Message-ID: <20171219083949.y5l6um5vohfait3g@linutronix.de>
References: <e27d043e-9565-f9fd-0b00-8fa5e123f147@ti.com>
 <20171218200612.7dce6787@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171218200612.7dce6787@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-12-18 20:06:12 [-0500], Steven Rostedt wrote:
> On Mon, 18 Dec 2017 18:55:24 -0600
> Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> 
> > Hi All,
> > 
> > I've tried to run stress-ng on TI am57xx-evm (SMP, 2 cpu) and caught 2  "INFO: possible circular locking dependency detected"
> > 
> > Command 1 (log 1):
> > ## stress-ng --class cpu --all 0 -t 5m &   stress-ng --class memory --all 0 --vm-bytes 90% -t 5m
> > 
> > Command 2 (log 2):
> > ## stress-ng --class os --all 0 -t 5m
> > 
> > actually command 2 often stuck or crushes (Log3 - I've collected 3 different dumps)
> > 
> 
> I hate to tell you but CPU hotplug is known to be broken on 4.9-rt and
> earlier. Hopefully the v4.14-rt code with the redesigned hotplug work
> fixes all this.

Yes, the v4.9-RT hotplug is not perfect. It works in general but can
fall apart with some load or "just" deadlock during CPU-down.
The v4.14-RT should not suffer from this and work.

> -- Steve

Sebastian
