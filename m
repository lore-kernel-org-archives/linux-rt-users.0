From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: [ptrace, rt] erratic behaviour in PTRACE_SINGLESET on 4.13-rt
 and later.
Date: Mon, 14 Jan 2019 15:45:47 +0100
Message-ID: <20190114144547.bgvkgv24g2odrek4@linutronix.de>
References: <20181119194619.GA32121@zipoli.concurrent-rt.com>
 <20181120122900.625b1d98@gandalf.local.home>
 <20181127085819.7e0865ee@tagon>
 <20181127151004.GB15742@zipoli.concurrent-rt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Steven Rostedt <rostedt@goodmis.org>,
        "julia@ni.com" <julia@ni.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Korty <Joe.Korty@concurrent-rt.com>
To: John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181127151004.GB15742@zipoli.concurrent-rt.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-11-27 15:10:07 [+0000], Joe Korty wrote:
> Hi Clark,
Hi Clark,

> No I don't, sorry.  I am attaching the LAG version, it is a few
> dozen lines shorter than the version I first sent out to the
> mailing list.

Did this make its way to rt-tests? I have some changes on top of it
while I was looking for the bug…

Sebastian
