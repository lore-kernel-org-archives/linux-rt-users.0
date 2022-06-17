Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383A7C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Jun 2022 11:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382066AbiFQLwM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Jun 2022 07:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381965AbiFQLwM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Jun 2022 07:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BBC16CF73
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Jun 2022 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655466730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3UtU3TCMnLtWdbUrXGHinm9uXWVLzhvaPtWr3iNWp5s=;
        b=YC7x49xX++ai1pSjUDqSoD8jo/0QkS1xNjP7GQtGy8UlHfOpogywA969flZ8p178b395+C
        /VwEWOzBu9g+Rt9EyselKe5xgfVUtkwnIgRkZk0n8pB2rYXxA6Ax+NdOAp5R3tdnVvn6Af
        0kxSftmCTCHaVyddsmpcxBWnrnYya94=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-RVCZdeQQONazl4O1S0u3ZQ-1; Fri, 17 Jun 2022 07:52:09 -0400
X-MC-Unique: RVCZdeQQONazl4O1S0u3ZQ-1
Received: by mail-wr1-f71.google.com with SMTP id v8-20020adfa1c8000000b0021b81a553fbso287461wrv.18
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Jun 2022 04:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3UtU3TCMnLtWdbUrXGHinm9uXWVLzhvaPtWr3iNWp5s=;
        b=24OEAQBTtQTi82UCo2Bfa9ySFK/05FXBzGblkIBE9LdbafO6GUag/JQ0oF9oxlvzMv
         bc0C/5rn7S4mv5IY6fc3G09NGG3W5UmPyiF5n+gvuTe/HiFMDZ6ssahyblrafCY0f1n3
         rQiHEhpozmtxpeHy569ctbS9D6L12LSZVynaP5kyiTu6ieyfokd/DPw3neoVZ6d3ZO+n
         CbKCCaA9b7Co8uO+DNB2dR1BTF978aoBrHkD5ZZKwb1m0hQJjPCx6c8lho3ypc3Pc1sn
         k4TtHp1ofG6v5CMFq+woIVjQ/nUCWIO2+beXmXul9nMFoACLm1UqbOzXbJ2AyEfLIV+U
         p5Og==
X-Gm-Message-State: AJIora/QbO5n9iap2eMw4xmvW3i4dXVS54iW9vYhXeZ2TSSP2crJ/ptO
        FeDlppMgmxZpE4UTYuWMGDTYEJ1EFOOCifzRy6jM2+1E0NDCQMIY3m2c+DetpjoaA0zyttEP+aV
        C80WgaBG7CHNFr/O135LQrRzYYlU=
X-Received: by 2002:adf:db8e:0:b0:21b:4e5b:a438 with SMTP id u14-20020adfdb8e000000b0021b4e5ba438mr2129625wri.247.1655466728032;
        Fri, 17 Jun 2022 04:52:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s0ZXtp9VXtpkNSKsIxSAqZTxBymeFRvrwy1fhKey/Whqc3mgxQ2nRJeEfXi0zexEG1HEHPDg==
X-Received: by 2002:adf:db8e:0:b0:21b:4e5b:a438 with SMTP id u14-20020adfdb8e000000b0021b4e5ba438mr2129616wri.247.1655466727813;
        Fri, 17 Jun 2022 04:52:07 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d4b86000000b0020cdcb0efa2sm4506890wrt.34.2022.06.17.04.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 04:52:07 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
In-Reply-To: <Yqxaf6V+hvCSXQSM@geo.homenetwork>
References: <20220616123709.347053-1-vschneid@redhat.com>
 <Yqxaf6V+hvCSXQSM@geo.homenetwork>
Date:   Fri, 17 Jun 2022 12:52:05 +0100
Message-ID: <xhsmhh74j7biy.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tao,

On 17/06/22 18:42, Tao Zhou wrote:
> Hi Valentin,
>
> On Thu, Jun 16, 2022 at 01:37:09PM +0100, Valentin Schneider wrote:
>> @@ -964,24 +966,31 @@ late_initcall(kexec_core_sysctl_init);
>>   */
>>  void __noclone __crash_kexec(struct pt_regs *regs)
>>  {
>> -	/* Take the kexec_mutex here to prevent sys_kexec_load
>> -	 * running on one cpu from replacing the crash kernel
>> -	 * we are using after a panic on a different cpu.
>> +	/*
>> +	 * This should be taking kexec_mutex before doing anything with the
>> +	 * kexec_crash_image, but this code can be run in NMI context which
>> +	 * means we can't even trylock.
>>  	 *
>> -	 * If the crash kernel was not located in a fixed area
>> -	 * of memory the xchg(&kexec_crash_image) would be
>> -	 * sufficient.  But since I reuse the memory...
>> +	 * Pairs with smp_mb() in do_kexec_load() and sys_kexec_file_load()
>>  	 */
>> -	if (mutex_trylock(&kexec_mutex)) {
>> -		if (kexec_crash_image) {
>> -			struct pt_regs fixed_regs;
>> -
>> -			crash_setup_regs(&fixed_regs, regs);
>> -			crash_save_vmcoreinfo();
>> -			machine_crash_shutdown(&fixed_regs);
>> -			machine_kexec(kexec_crash_image);
>> -		}
>> -		mutex_unlock(&kexec_mutex);
>> +	WRITE_ONCE(panic_wants_kexec, true);
>> +	smp_mb();
>> +	/*
>> +	 * If we're panic'ing while someone else is messing with the crash
>> +	 * kernel, this isn't going to end well.
>> +	 */
>> +	if (READ_ONCE(kexec_loading)) {
>> +		WRITE_ONCE(panic_wants_kexec, false);
>> +		return;
>> +	}
>
> So this is from NMI. The mutex guarantee that kexec_file_load() or 
> do_kexec_load() just one of them beat on cpu. NMI can happen on more
> than one cpu. That means that here be cumulativity here IMHO.
>

If you look at __crash_kexec() in isolation yes, but if you look at panic()
and nmi_panic() only a single NMI can get in there. I think that is also
true for invocations via crash_kexec().


> kexec_file_load()/                 NMI0                     NMI1..
> do_kexec_load()
>
> set kexec_loading=true     
> smp_mb()                set panic_wants_kexec=ture
>                         smp_mb()
>                         see kexec_loading=ture and
>                           conditionally set
>                           panic_wants_kexec=false;
>                                                  set panic_wants_kexec=ture
>                                                  smp_mb()
> see panic_wants_kexec=ture
>   conditionally set
>   kexec_loading=false
>                                                  see kexec_loading=false
>                                                  do kexec nmi things.
>
> You see conditionlly set kexec_loading or panic_wants_kexec there no barrier
> there and if the cumulativity to have the effect there should be a acquire-release,
> if I am not wrong.
>
> __crash_kexec():
>
> WRITE_ONCE(panic_wants_kexec, true);
> smp_mb();
> /*
>  * If we're panic'ing while someone else is messing with the crash
>  * kernel, this isn't going to end well.
>  */
> if (READ_ONCE(kexec_loading)) {
> 	smp_store_release(panic_wants_kexec, false);
> 	return;
> }
>
> kexec_file_load()/do_kexec_load():
>
> WRITE_ONCE(kexec_loading, true);
> smp_mb();
> if (smp_load_acquire(panic_wants_kexec)) {
>     WRITE_ONCE(kexec_loading, false);
>     ...
> }
>
> For those input, I'm sure I lost and feel hot..
> I thought that change the patten to load-store and set initial
> value but failed.
>

I'm not sure if further ordering is required here, the base case being

  WRITE_ONCE(panic_wants_kexec, true);         WRITE_ONCE(kexec_loading);
  smp_mb();                                    smp_mb();
  v0 = READ_ONCE(kexec_loading);               v1 = READ_ONCE(panic_wants_kexec);

  (see SB+fencembonceonces litmus test)

Wich ensures (!v0 && !v1) is never true. If modified to:

  WRITE_ONCE(panic_wants_kexec, true);         WRITE_ONCE(kexec_loading);
  smp_mb();                                    smp_mb();
  v0 = READ_ONCE(kexec_loading);               v1 = READ_ONCE(panic_wants_kexec);  
  if (v0)                                      if (v1)
          WRITE_ONCE(panic_wants_kexec, false);        WRITE_ONCE(kexec_loading, false);

then "(!v0 && !v1) is never true" still holds, so the exclusivity is
maintained AFAICT.

