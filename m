From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH RT] arm*: disable NEON in kernel mode
Date: Fri, 1 Dec 2017 15:03:35 +0000
Message-ID: <24FDBFF1-8351-46FC-885A-6B6F972F4C6C@linaro.org>
References: <20171130142216.GB12606@linutronix.de> <20171130143028.GA1351@linutronix.de> <20171201104331.GB1612@linutronix.de> <20171201134506.GF1612@linutronix.de> <20171201141827.yip6pl3tt7kxzek7@lakrids.cambridge.arm.com> <20171201143648.GK1612@linutronix.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171201143648.GK1612@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


l
> On 1 Dec 2017, at 14:36, Sebastian Andrzej Siewior <bigeasy@linutronix.de>=
 wrote:
>=20
>> On 2017-12-01 14:18:28 [+0000], Mark Rutland wrote:
>> [Adding Ard, who wrote the NEON crypto code]
>>=20
>>> On Fri, Dec 01, 2017 at 02:45:06PM +0100, Sebastian Andrzej Siewior wrot=
e:
>>> +arm folks, to let you know
>>>=20
>>>> On 2017-12-01 11:43:32 [+0100], To linux-rt-users@vger.kernel.org wrote=
:
>>>> NEON in kernel mode is used by the crypto algorithms and raid6 code.
>>>> While the raid6 code looks okay, the crypto algorithms do not: NEON
>>>> is enabled on first invocation and may allocate/free/map memory before
>>>> the NEON mode is disabled again.
>>=20
>> Could you elaborate on why this is a problem?
>>=20
>> I guess this is because kernel_neon_{begin,end}() disable preemption?
>>=20
>> ... is this specific to RT?
>=20
> It is RT specific, yes. One thing are the unbounded latencies since
> everything in this preempt_disable section can take time depending on
> the size of the request.
> The other thing is code like in
>  arch/arm64/crypto/aes-ce-ccm-glue.c:ccm_encrypt()
>=20
> where within this preempt_disable() section skcipher_walk_done() is
> invoked. That function can allocate/free/map memory which is okay for
> !RT but is not for RT. I tried to break those loops for x86 [0] and I
> simply didn't had the time to do the same for ARM. I am aware that
> store/restore of the NEON registers (as SSE and AVX) is expensive and
> doing a lot of operations in one go is desired.

I wouldn=E2=80=99t mind fixing the code instead. We never disable the neon, b=
ut only stack the contents of the registers the first time, and unstack them=
 only before returning to userland (with the exception of nested neon use in=
 softirq context). When this code was introduced, we always stacked/unstacke=
d the whole register file eagerly every time.


> So for x86 I would want
> to do some benchmarks and come up with some numbers based on which I
> can argue with people one way or another depending on how much it hurts
> and how long preemption can be disabled.
>=20
> [0] https://www.spinics.net/lists/kernel/msg2663115.html
>=20
>> Thanks,
>> Mark.
>=20
> Sebastian
