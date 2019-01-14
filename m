From: John Kacur <jkacur@redhat.com>
Subject: Re: [ptrace, rt] erratic behaviour in PTRACE_SINGLESET on 4.13-rt and later.
Date: Mon, 14 Jan 2019 18:09:07 +0100
Message-ID: <20190114170908.5287-1-jkacur@redhat.com>
Reply-To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "julia @ ni . com" <julia@ni.com>,
        "tglx @ linutronix . de" <tglx@linutronix.de>,
        "oleg @ redhat . com" <oleg@redhat.com>,
        "linux-rt-users @ vger . kernel . org"
        <linux-rt-users@vger.kernel.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
To: Joe Korty <Joe.Korty@concurrent-rt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Sebastian: I added the test from Joe Korty to rt-tests. Working on integrating it into the build, but I wanted to make it available before that so you
could send me your patches.

Repo:   git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
Branch: unstable/devel/latest

Thanks
John Kacur
