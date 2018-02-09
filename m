From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 00/20] crypto: arm64 - play nice with CONFIG_PREEMPT
Date: Fri, 9 Feb 2018 19:28:23 +0000
Message-ID: <CAKv+Gu9o7k0jrrc0jHYUbcJ2k+pmo4N-PHYEZrr_vj=nx-3Z+g@mail.gmail.com>
References: <20171226102940.26908-1-ard.biesheuvel@linaro.org> <20180209180222.qsi7jcw7pj442rpo@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180209180222.qsi7jcw7pj442rpo@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 9 February 2018 at 18:02, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2017-12-26 10:29:20 [+0000], Ard Biesheuvel wrote:
>> As reported by Sebastian, the way the arm64 NEON crypto code currently
>> keeps kernel mode NEON enabled across calls into skcipher_walk_xxx() is
> =E2=80=A6
>> So let's clean this up for arm64: update the NEON based skcipher drivers=
 to
>> no longer keep the NEON enabled when calling into the skcipher walk API.
>
> Thanks for working on this.
> What is the status of this? Is this going to be merged?
>

Without anybody acking or reviewing it, this is not going to be
merged, so I kind of gave up.
