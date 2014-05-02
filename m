From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 2/2] rtmutex: Remove duplicate rt_mutex_init()
Date: Fri, 02 May 2014 15:21:51 +0200
Message-ID: <53639BEF.60008@linutronix.de>
References: <20140409024700.702797305@goodmis.org>	<20140409025232.161960044@goodmis.org>	<20140502090831.GB9178@linutronix.de> <20140502091213.3ed4ba7b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
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
In-Reply-To: <20140502091213.3ed4ba7b@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 05/02/2014 03:12 PM, Steven Rostedt wrote:
>> This does not apply cleanly on v3.14-rt
>=20
> That's because I sent this out before 3.14-rt was released :-)

Ach right. Sorry, my memory=85

>>> --- a/include/linux/rtmutex.h
>>> +++ b/include/linux/rtmutex.h
>>> @@ -62,25 +62,19 @@ struct hrtimer_sleeper;
>>> # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
>>> 	, .name =3D #mutexname, .file =3D __FILE__, .line =3D __LINE__
>>>
>>> -# define rt_mutex_init(mutex)					\
>>> -	do {							\
>>> -		raw_spin_lock_init(&(mutex)->wait_lock);	\
>>> -		__rt_mutex_init(mutex, #mutex);			\
>>> -	} while (0)
>>> -
>>
>> The macro is the same in CONFIG_DEBUG_RT_MUTEXES and the else path.
>> Shouldn't you remove both and define it before the ifdef?
>=20
> That's exactly what the patch did! Except that it defined it *after* =
the ifdef.
>=20
> Here's the patch again (as it was cut in the reply):
>=20
> --- a/include/linux/rtmutex.h
> +++ b/include/linux/rtmutex.h
> @@ -62,25 +62,19 @@ struct hrtimer_sleeper;
>  # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
>  	, .name =3D #mutexname, .file =3D __FILE__, .line =3D __LINE__
> =20
> -# define rt_mutex_init(mutex)					\
> -	do {							\
> -		raw_spin_lock_init(&(mutex)->wait_lock);	\
> -		__rt_mutex_init(mutex, #mutex);			\
> -	} while (0)
> -
>   extern void rt_mutex_debug_task_free(struct task_struct *tsk);
>  #else
>  # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname)
> =20
> +# define rt_mutex_debug_task_free(t)			do { } while (0)
> +#endif
> +
>  # define rt_mutex_init(mutex)					\
>  	do {							\
>  		raw_spin_lock_init(&(mutex)->wait_lock);	\
>  		__rt_mutex_init(mutex, #mutex);			\
>  	} while (0)
> =20
> -# define rt_mutex_debug_task_free(t)			do { } while (0)
> -#endif
> -
>  #define __RT_MUTEX_INITIALIZER_PLAIN(mutexname) \
>  	.wait_lock =3D __RAW_SPIN_LOCK_UNLOCKED(mutexname.wait_lock) \
>  	, .wait_list =3D PLIST_HEAD_INIT(mutexname.wait_list) \
>=20
> Take special note of the movement of the "#endif".

Ah. That is the trick. So lets try it again=85

> -- Steve

Sebastian
