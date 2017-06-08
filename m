From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: kernel BUG at kernel/locking/rtmutex.c:1027
Date: Thu, 8 Jun 2017 10:03:05 +0200
Message-ID: <20170608080305.kv5zsyhxfnsmtgul@linutronix.de>
References: <2B18E8E1DDAE074A82D1060396451DAE263C7C1A@CNMAILEX04.lenovo.com>
 <1496907099.8617.31.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Feng Feng24 Liu <liufeng24@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tmac@hp.com" <tmac@hp.com>, Tong Tong3 Li <litong3@lenovo.com>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496907099.8617.31.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-08 09:31:39 [+0200], Mike Galbraith wrote:
> On Thu, 2017-06-08 at 07:01 +0000, Feng Feng24 Liu wrote:
> >  
> > 	Our kernel version is:  kernel4.4.6-rt14
> > 
> 
> Latest 4.4-rt is 4.4.70-rt83...

Exactly. Please test it with the latest v4.4 RT tree.
	https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/

Sebastian
