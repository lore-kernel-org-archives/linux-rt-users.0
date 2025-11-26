Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5E2874E1
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Nov 2025 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169664; cv=none; b=LurAcBYthKaj020hcDLOEpL7de2JsvcMKb8UK99lW/zmeb2ezTeh8VYWs7gdB0o5IRvlD/QjpucEqnCfCgtB8hUEbyB256qoYvIAfOIwapgzdXMsgNlh5XZVKdO2CRoA9Zpd9hbdiO56yRwvilUpSb9ZlxCihw1difvsb5MBorU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169664; c=relaxed/simple;
	bh=B1OqPj4icP8atuhO+OkPH6N38Wk+JWMgZsf4RS5H78U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mg/ADKBSY0j0y25TT2d5SH5ZyBkIpdl0H+8EqWvpufng2tJStJnTmSTKZQDtzdBs6kobj+Mmn0Jjd2sArfn1lqJsnalZaoKV5qYJ9AYmsQuQlqfpaTHwpkA81Hqa2Ng4eCxwWPJ2K7w8JbF5F53iBf5070pqak7nxwjCVlWFUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=JkIJlcvl; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="JkIJlcvl"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251126150727108167a0a30002076e
        for <linux-rt-users@vger.kernel.org>;
        Wed, 26 Nov 2025 16:07:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8PotcrPgkJTpLiPpX8BQ1YzP7zpkYZxvb46cHr2kBug=;
 b=JkIJlcvl7E6Wt5yC5YxWxSSBDxneLL8p2vvlDPVjdESMxSJ4iZvdgLw2wo4di+DCqDAwsy
 E4NL8el/ZNU0j39cZ0sw6sjGA22Jj3Tv6+2Fe7BF0vBEAaBelWl75pNWYMLXS0u/ZP+Oi3ki
 YDhc6RRfX7FnXXSB9RwN2pWtT+eVOee5NANtP5JqGIdFARQqjkhQnBpIc5az1pb5KL9qDVoR
 rVubF+yTspaGIbIaGKkqIDghzh0WBH8GPdvTPenuFzE1LK0OXKd9ZC09mDOfLdrqLpr3WHct
 OCs/483zdd2LusoX/flI7o2ksmZVZ1Fug91ZLvH5IaHR5m01MBRMLgkw==;
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Nov 2025 16:07:26 +0100
Message-Id: <DEIPY3BS8AHL.1YJ1980URTLYH@siemens.com>
Cc: "Preclik, Tobias" <tobias.preclik@siemens.com>, "Frederic Weisbecker"
 <frederic@kernel.org>, "linux-rt-users@vger.kernel.org"
 <linux-rt-users@vger.kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "Waiman Long" <longman@redhat.com>, "Gabriele Monaco" <gmonaco@redhat.com>
Subject: Re: Control of IRQ Affinities from Userspace
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>
References: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
 <20251103155322.Aw9MSNYv@linutronix.de>
 <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>
 <6523960abaff2054ed25bf57b2a12e381f305a3e.camel@siemens.com>
 <20251111143456.YML0ggA7@linutronix.de>
 <cce633df665f167291d975c0c13dab990e267384.camel@siemens.com>
 <20251124095919.V73BtuvW@linutronix.de>
 <387396748522d2279c3188e5c2b4345bc2211556.camel@siemens.com>
 <20251125115008.-R5m5dX9@linutronix.de>
 <767a8c7c1c88d930c5e7d7b39e7081c3cb39a08c.camel@siemens.com>
 <87tsyigjkc.ffs@tglx>
 <4de393b9304c99386d847ed0694ec12075a99c0a.camel@siemens.com>
 <87fra0hntv.ffs@tglx>
In-Reply-To: <87fra0hntv.ffs@tglx>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed Nov 26, 2025 at 3:26 PM CET, Thomas Gleixner wrote:
> On Wed, Nov 26 2025 at 10:20, Florian Bezdeka wrote:
>> On Tue, 2025-11-25 at 17:31 +0100, Thomas Gleixner wrote:
>>> > This question can not be answered with yes/no. It depends. Affinities
>>> > are based on the default_smp_affinity during creation. But as it turn=
ed
>>> > out there are drivers that overwrite those affinities after IRQ
>>> > creation.
>>>=20
>>> Which ones?
>>
>> The problem at hand is the stmmac
>> (drivers/net/ethernet/stmicro/stmmac/stmmac_main), which is pulled in by
>> a couple of others like the dwmac_intel in our case.
>>
>> Searching for the problematic irq_set_affinity_hint() call in
>> drivers/net/ethernet reveals more "affected" drivers but each of them
>> requires some double checking. In some cases the supplied cpumask or the
>> "time of the call" might be OKish.
>
> The question is whether that affinity hint has a functional requirement
> to be applied or not. I don't think so because those interrupts can be
> moved by userspace as it sees fit.

The background seems performance. Those NICs support link speeds up to
(or even above) 2.5Gbit/s. Seems it's hard to fully utilize the link
when all queues are routed - IRQ wise - to a single core.

This is now the point where the IRQ chips matters. Some (like APIC for
x86) have the IRQ balancing implemented in SW, while others don't have
that. So the driver does that manually by ignoring all the RT settings.

>
> So it's easy enough to make this "set" part conditional and restrict it
> to some TBD mask (housekeeping, default ...) under some isolation magic.
>

For now I would be happy if I could modify the stmmac in a way that its
balancing takes the default affinity into account. I couldn't find any
available API that allows me to do so from a module.

Are there any strong reasons for not exporting the default affinity from
the IRQ core? Read-only would be enough.

>>> > The user normally configures the number of HW queues that the NIC sho=
uld
>>> > use. In most cases in combination with some HW packet filters to achi=
eve
>>> > best packet separation. IMHO the user should not have to deal with an=
y
>>> > (additional) CPU mask on that level. RT tuning will / should handle
>>> > that.
>>>=20
>>> How so. The kernel magically knows what the user wants?
>>
>> We can already identify the IRQs that belong to a certain hardware queue
>> (NAPI threads) and move it when necessary. I just wanted to express that
>> there might not be a need for an additional API / cpumask.
>
> Ok.
>
>>> Not a so dead road :)
>>
>> Grml... I definitely fat-fingered the query. Anyway, this housekeeping
>> API still seems very boot-time oriented to me. Can't see yet where this
>> housekeeping cpumasks are filled up by the cgroup/cpuset infrastructure.
>>
>> cgroups/cpusets don't care about "isolation" in that sense yet. It's
>> just about cpumasks for compute. Am I missing something?
>
> There is work in progress on various related ends:
>
>   https://lore.kernel.org/all/20251105210348.35256-1-frederic@kernel.org
>   https://lore.kernel.org/all/20251120145653.296659-1-gmonaco@redhat.com
>   https://lore.kernel.org/all/20251105043848.382703-1-longman@redhat.com
>   https://lore.kernel.org/all/20251121143500.42111-3-frederic@kernel.org
>
> There is certainly more going on it that area, but those were the bits
> and pieces I could remember from the top of my head. Waiman and Gabriele
> should be able to fill in some blanks, but that discussion should move
> to LKML then.

Thanks for the pointers! I was aware of most of them. This still seems
very static as the housekeeping cpumasks are filled up on boot with
kernel cmdline arguments.

In addition I'm quite sure that the housekeeping infrastructure would
not help in the area of networking as nobody (except one driver) is
based on the managed IRQ API.

Florian
