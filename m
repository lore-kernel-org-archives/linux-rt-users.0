From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 2/2] rtmutex: Remove duplicate rt_mutex_init()
Date: Fri, 2 May 2014 11:08:31 +0200
Message-ID: <20140502090831.GB9178@linutronix.de>
References: <20140409024700.702797305@goodmis.org>
 <20140409025232.161960044@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140409025232.161960044@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2014-04-08 22:47:02 [-0400]:

>From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
>
>The rt_mutex_init() macro is the same whether or not
>CONFIG_DEBUG_RT_MUTEX is set. Remove the duplicate.
>
>Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

This does not apply cleanly on v3.14-rt

>--- a/include/linux/rtmutex.h
>+++ b/include/linux/rtmutex.h
>@@ -62,25 +62,19 @@ struct hrtimer_sleeper;
> # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
> 	, .name = #mutexname, .file = __FILE__, .line = __LINE__
> 
>-# define rt_mutex_init(mutex)					\
>-	do {							\
>-		raw_spin_lock_init(&(mutex)->wait_lock);	\
>-		__rt_mutex_init(mutex, #mutex);			\
>-	} while (0)
>-

The macro is the same in CONFIG_DEBUG_RT_MUTEXES and the else path.
Shouldn't you remove both and define it before the ifdef? There are some
users of this:
|drivers/i2c/i2c-core.c: rt_mutex_init(&adap->bus_lock);
|drivers/media/usb/em28xx/em28xx-cards.c: rt_mutex_init(&dev->i2c_bus_lock);

Sebastian
