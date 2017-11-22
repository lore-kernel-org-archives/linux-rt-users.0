From: Mike Galbraith <efault@gmx.de>
Subject: Re: [BUG] 4.4.x-rt - memcg: refill_stock() use get_cpu_light() has
 data corruption issue
Date: Wed, 22 Nov 2017 15:09:20 +0100
Message-ID: <1511359760.8762.2.camel@gmx.de>
References: <05AA4EC5C6EC1D48BE2CDCFF3AE0B8A637F78A15@CNMAILEX04.lenovo.com>
         <20171121225002.0704d679@vmware.local.home>
         <1511329005.8762.0.camel@gmx.de>
         <20171122065955.15ac5039@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Haiyang HY1 Tan <tanhy1@lenovo.com>,
        "'bigeasy@linutronix.de'" <bigeasy@linutronix.de>,
        "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Tong Tong3 Li <litong3@lenovo.com>,
        Feng Feng24 Liu <liufeng24@lenovo.com>,
        Jianqiang1 Lu <lujq1@lenovo.com>,
        Hongyong HY2 Zang <zanghy2@lenovo.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122065955.15ac5039@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2017-11-22 at 06:59 -0500, Steven Rostedt wrote:
> 
> You see. No more spin lock to gripe about. No boom in your scenario.

And patches--, perfect.

	-Mike
