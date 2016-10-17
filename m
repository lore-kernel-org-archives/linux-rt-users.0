From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch] drivers,connector: Protect send_msg() with a local lock
 for RT
Date: Mon, 17 Oct 2016 16:16:05 +0200
Message-ID: <20161017141605.2ejqqcx5xmimnif5@linutronix.de>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
 <1476587514.1538.5.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476587514.1538.5.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-10-16 05:11:54 [+0200], Mike Galbraith wrote:
> 

applied with smaller changes. This is v4.8-RT only.

Sebastian
