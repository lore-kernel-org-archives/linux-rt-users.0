From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] use local spin_locks in local_lock
Date: Fri, 31 Jan 2014 21:24:45 +0100
Message-ID: <20140131202445.GB21238@linutronix.de>
References: <20131229171154.GA23586@opentech.at>
 <20140117144729.GB5785@linutronix.de>
 <20140117145955.GA5637@opentech.at>
 <52D94891.80109@linutronix.de>
 <20140117153323.GA23566@opentech.at>
 <20140117113218.7392363d@gandalf.local.home>
 <20140117194158.GB20157@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org,
	Sami Pietikainen <Sami.Pietikainen@wapice.com>,
	Jouko Haapaluoma <jouko.haapaluoma@wapice.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140117194158.GB20157@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Nicholas Mc Guire | 2014-01-17 20:41:58 [+0100]:

>
>Drop recursive call to migrate_disabel/enable for local_*lock* api
>reported by Steven Rostedt.

Applied.

Sebastian
