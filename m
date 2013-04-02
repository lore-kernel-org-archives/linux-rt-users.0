From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [RT LATENCY] 249 microsecond latency caused by slub's
 unfreeze_partials() code.
Date: Tue, 2 Apr 2013 09:48:20 +0300
Message-ID: <CAOJsxLG8WT08URRzCLQ5VYBXx54PX3c=v5_-tJmC_H=FwtvjnA@mail.gmail.com>
References: <0000013da2ce20f8-0e3a64ef-67ed-4ab4-9f20-b77980c876c3-000000@email.amazonses.com>
	<1364236355.6345.185.camel@gandalf.local.home>
	<20130327025957.GA17125@lge.com>
	<1364355032.6345.200.camel@gandalf.local.home>
	<20130327061351.GB17125@lge.com>
	<alpine.DEB.2.02.1303281227520.16200@gentwo.org>
	<0000013db20ca149-0064fbb8-2f81-4323-9095-a38f6abb79c5-000000@email.amazonses.com>
	<CAP=VYLr4i=39ywFCrmG-XuvUFmmXpyj6dYgG44JJoUJhpN6uuQ@mail.gmail.com>
	<alpine.DEB.2.02.1304011025550.12690@gentwo.org>
	<0000013dc63b3a87-6ce88b75-d011-407e-8dde-da73c3a7f5fd-000000@email.amazonses.com>
	<20130402004217.GA16699@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christoph Lameter <cl@linux.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130402004217.GA16699@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Apr 2, 2013 at 3:42 AM, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
>> I have a vague memory that Joonsoo also ran into this issue awhile back.
>
> Yes. I sent a patch for this two month ago. :)

It's applied now.

                       Pekka
