From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [PATCH RT 0/3] Linux 3.2.57-rt84-rc1
Date: Mon, 28 Apr 2014 02:15:28 +0400
Message-ID: <535D8180.1020607@pavlinux.ru>
References: <20140427143925.177486597@goodmis.org>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140427143925.177486597@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

27.04.2014 18:39, Steven Rostedt =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Dear RT Folks,
>
> This is the RT stable review cycle of patch 3.2.57-rt84-rc1.
>
> Please scream at me if I messed something up. Please test the patches=
 too.


More than two years our thin clients (about 5000 machines, Intel Atom, =
x86_32)=20
work with RCU_BOOST.

CONFIG_RCU_BOOST=3Dy
CONFIG_RCU_BOOST_PRIO=3D80
CONFIG_RCU_BOOST_DELAY=3D400

--=20

                                                          Pavel.
