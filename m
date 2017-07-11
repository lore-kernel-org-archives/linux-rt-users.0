From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpu_pm: replace raw_notifier to atomic_notifier
Date: Tue, 11 Jul 2017 17:01:09 +0200
Message-ID: <71438284.RUbDNKAoy6@aspire.rjw.lan>
References: <1499330866-19520-1-git-send-email-alex.shi@linaro.org> <6cbcde77-8911-8439-9603-b2c1ae1dc595@linaro.org> <20170711150634.jwwiamei25q2veyx@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Alex Shi <alex.shi@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rik van Riel <riel@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170711150634.jwwiamei25q2veyx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday, July 11, 2017 05:06:35 PM Sebastian Andrzej Siewior wrote:
> On 2017-07-11 22:42:04 [+0800], Alex Shi wrote:
> > It is a serious bug: add a waiting lock in idle and cause boot failure
> > in arm/arm64 RT.
> > 
> > Any more comments for this change?
> 
> As far as RT is concerned, I am taking this for the next v4.11 release.
> I would appreciate if upstream would apply this as well.
> Rafael do you feel responsible for this?

I can apply this if no one else wants to. :-)

However, I'd appreciate a resend with a CC to linux-pm@vger.kernel.org for
easier processing.

Thanks,
Rafael
