From: Monica Puig-Pey <puigpeym@unican.es>
Subject: Re: Changing Kernel thread priorities
Date: Tue, 7 Jun 2011 10:32:50 +0200
Message-ID: <4DEDE232.4090007@unican.es>
References: <17185480.5304.1307435255996.JavaMail.root@WARSBL214.highway.tel
	ekom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	Rolando Martins <rolando.martins@gmail.com>,
	<linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	tglx <tglx@linutronix.de>
To: <hannes_bauer@aon.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <17185480.5304.1307435255996.JavaMail.root@WARSBL214.highway.te
	lekom.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

El 07/06/11 10:27, Johannes Bauer escribi=C3=B3:
> Absolutly correct!
>
> However, if you are running the system on an embedded platform, where=
 the _WHOLE_ system (including priorities) is preconfigured and never t=
ouched, starting a irq thread with the right prio from start is a more =
straightforward method than having to invoke a script that changes it u=
sing userspace chrt tool.
>
> Regards JB
> ----- Urspr=C3=BCngliche Nachricht -----
> Von: "Peter Zijlstra"<peterz@infradead.org>
> Erhalten: 07.06.2011 00:36
> An: hannes_bauer@aon.at
>
> "Monica Puig-Pey" wrote:
>>
>> I need to change the priority from inside the driver, when creating =
the
>> kernel thread.
>
> No you don't. How does you driver know about what priority is correct
> wrt all the other running RT tasks on the system?
>
> Determining the right priority in a fixed priority scheduling system =
is
> a system wide problem, nobody but the administrator can possibly even
> begin to solve it.
>
> There's a reason all RT irq threads are started at 50, its plain
> impossible to do better.
>

That's it!
If I work with embedded system where I know all my tasks running and=20
there is not a user how could I do it?

What I tried is create the kernel thread in my init_module using:

	#include <linux/kthread.h>

	struct task_struct *kthread_create(int (*threadfn)(void *data),
				   void *data,
				   const char namefmt[], ...)
and then running it with:

	#include <linux/sched.h>
=09
	extern int wake_up_process(struct task_struct *tsk);

These functions stars a Kthread which has a NON RT priority. I can see=20
this using the ps command from user space.
Because it's not a real time thread is why I want, better need, to=20
change its priority, to have only real time threads running in my=20
driver. I want to use the Kthread as a bottom half for the interrupts.

How could I create real time kernel threads then? is kthread_create=20
wrong for real time enviroment?


--=20
_______________________________________________________________________=
___________

M=C3=B3nica Puig-Pey Gonz=C3=A1lez       E-mail: puigpeym@unican.es

Grupo de Computadores y Tiempo Real, Departamento de Electr=C3=B3nica y=
=20
Computadores.
=46acultad de Ciencias - Universidad de Cantabria
Av. de los Castros s/n. 39005 - Santander, Espa=C3=B1a
_______________________________________________________________________=
___________
