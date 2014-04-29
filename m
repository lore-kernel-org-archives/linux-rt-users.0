From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [PATCH RT 0/3] Linux 3.2.57-rt84-rc1
Date: Tue, 29 Apr 2014 19:48:37 +0400
Message-ID: <535FC9D5.4040107@pavlinux.ru>
References: <20140427143925.177486597@goodmis.org>	<535D8180.1020607@pavlinux.ru> <20140428093956.78d0f3ea@gandalf.local.home>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140428093956.78d0f3ea@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

28.04.2014 17:39, Steven Rostedt =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Mon, 28 Apr 2014 02:15:28 +0400
> Pavel Vasilyev <pavel@pavlinux.ru> wrote:
>
>> 27.04.2014 18:39, Steven Rostedt =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> Dear RT Folks,
>>>
>>> This is the RT stable review cycle of patch 3.2.57-rt84-rc1.
>>>
>>> Please scream at me if I messed something up. Please test the patch=
es too.
>>
>>
>> More than two years our thin clients (about 5000 machines, Intel Ato=
m, x86_32)
>> work with RCU_BOOST.
>>
>> CONFIG_RCU_BOOST=3Dy
>> CONFIG_RCU_BOOST_PRIO=3D80
>> CONFIG_RCU_BOOST_DELAY=3D400
>>
>
> Is this just a confirmation of having RCU_BOOST default y for
> PREEMPT_RT is a good thing?


Only 3.2-rt


--=20

                                                          Pavel.
