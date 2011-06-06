From: Monica Puig-Pey <puigpeym@unican.es>
Subject: Changing Kernel thread priorities
Date: Mon, 6 Jun 2011 13:47:16 +0200
Message-ID: <4DECBE44.2070803@unican.es>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es>
	<4DEA255B.2050503@unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DEA255B.2050503@unican.es>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I am writing a driver which has one kernel thread associated with it.
I want to change the priority of this thread, so that I can specify the=
=20
order in which it is scheduled following an interrupt.
I'm using:

  sched_setscheduler(struct task_struct *, int, struct sched_param *);

but it doesn't work. I tried to change the priority from the=20
init_module, and also from the Kernel Thread, but there is no way.

Kernel version is 2.6.31-11-rt

What do I call to change a kernel thread priority?

Thanks you very much

M=F3nica
