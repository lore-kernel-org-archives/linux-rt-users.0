From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 3/6] rt: Make cpu_chill() use hrtimer instead of msleep()
Date: Fri, 07 Mar 2014 10:51:55 +0100
Message-ID: <531996BB.2050401@linutronix.de>
References: <20140305003333.402759240@goodmis.org> <20140305003346.602499217@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140305003346.602499217@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/05/2014 01:33 AM, Steven Rostedt wrote:
> 3.2.55-rt79-rc1 stable review patch.
> If anyone has any objections, please let me know.

Now that you posted "cpu_chill: Add a UNINTERRUPTIBLE
hrtimer_nanosleep" wouldn't it make sense to delay this patches from
the stable series until we get them all in one go?

Sebastian
