From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/5] crypto: arm64 - disable NEON across scatterwalk API calls
Date: Sat, 2 Dec 2017 09:11:46 +0000
Message-ID: <CAKv+Gu-dG0Zc35NZZ85U36K2TXCpN+wJTYOyjkhxRjXbdiJTAQ@mail.gmail.com>
References: <20171201211927.24653-1-ard.biesheuvel@linaro.org> <20171202090107.GT3326@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20171202090107.GT3326@worktop>
Sender: linux-crypto-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2 December 2017 at 09:01, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Dec 01, 2017 at 09:19:22PM +0000, Ard Biesheuvel wrote:
>> Note that the remaining crypto drivers simply operate on fixed buffers, so
>> while the RT crowd may still feel the need to disable those (and the ones
>> below as well, perhaps), they don't call back into the crypto layer like
>> the ones updated by this series, and so there's no room for improvement
>> there AFAICT.
>
> Do these other drivers process all the blocks fed to them in one go
> under a single NEON section, or do they do a single fixed block per
> NEON invocation?

They consume the entire input in a single go, yes. But making it more
granular than that is going to hurt performance, unless we introduce
some kind of kernel_neon_yield(), which does a end+begin but only if
the task is being scheduled out.

For example, the SHA256 keeps 256 bytes of round constants in NEON
registers, and reloading those from memory for each 64 byte block of
input is going to be noticeable. The same applies to the AES code
(although the numbers are slightly different)
