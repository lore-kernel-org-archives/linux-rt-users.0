From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] kernel/time/posix-timer: avoid schedule() while
 holding the RCU lock
Date: Wed, 28 Mar 2018 12:32:16 +0200
Message-ID: <20180328103215.hlt4rwsnblzav2vp@linutronix.de>
References: <20180323154057.pptgxusdgfb2h6ag@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wagner <wagi@monom.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180323154057.pptgxusdgfb2h6ag@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-03-23 16:40:57 [+0100], To linux-rt-users@vger.kernel.org wrote:

while this seems to work I am not quite happy with it and looking into
alternatives…

Sebastian
