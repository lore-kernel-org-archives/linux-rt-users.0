From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] futex: fix unbalanced spin_lock/spin_unlock() in exit_pi_state_list()
Date: Fri, 1 Mar 2013 13:01:19 +0100
Message-ID: <CAONaPpGUwHenOq9p_ktK10HqPCwZ_m9=Nj8qYWpKVxPhqQ8zjw@mail.gmail.com>
References: <1362101815-19968-1-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362101815-19968-1-git-send-email-yong.zhang0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Mar 1, 2013 at 2:36 AM, Yong Zhang <yong.zhang0@gmail.com> wrote:
> From: Yong Zhang <yong.zhang@windriver.com>
>
> Otherwise, below warning is shown somtimes when running some test:

It would be nice to know which test!
----->o SNIP
