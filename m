Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C41C433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 20:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4306864D99
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 20:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhBVUSE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 15:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhBVUSB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 15:18:01 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D53C061574
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 12:17:20 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id f17so13982720qkl.5
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 12:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=dyS6Pih8T9m6C+eS4ZYX0uaqUlCWR553IzdokKhNsOs=;
        b=G/BinU649xo9tDv6He4J7KboSaoG+BDrqsgxSknUDKtWnGT1xTGkADy2Ag5c1z+kbx
         AC5d13A4BUxtvyTECj2MN72TjBIzYQaP2wK6ozV+ZB7F4K2pkXMBPp2OdBAJbGc7abFD
         QhW0KBVp++WxcXebOVlMv8t3h0Kyd/Mddkm0pOaunF0BFRRpALYl0A+DLeuEugZ1uxn7
         W3dHmIH/LJ52da4Z4sMiMTros7fk7AEwKDoqenjKexeLKzEkCv+yj/QOHki21A1LgRiW
         0ZyHrmUlu2IvUON4QVfOIQj4FbNsBhA1YpTTG+Ih2O5ZF3RgnBtVA1UVCkspc0O5MD3z
         Ps9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=dyS6Pih8T9m6C+eS4ZYX0uaqUlCWR553IzdokKhNsOs=;
        b=gk5t1nGpTOPQR45yxxdrxpsDWgWFDJnXammxkWlPZeRy7RjiTcMrvV+JuqYJVmMTTi
         BwM4X50PY4kLwKYKBHnkVS+2tZgy5mm7Ue78y99XjqlfEMXHeGh9JVX0cIR9pmko0Qad
         /OJppg5NYwiw9UNVOPbFFe0kwPhaKPkm1x5j5N7/ZSvkM4/VLsYYF8sM7iJpC+cEUWIN
         8uE27WOjB9UM5rjeDZxb8V4tuPxQ4sqiwzoOyfj5eMBz9XGdtVf1JapsxTMjfPnbwnX2
         BaXHH7lHSMBbGQ6pxFJ2V/Kn/YTMrJJKbe5ME1e9xmL2ug2E9/FoZyTsx4VgFSkFNMHi
         v1mA==
X-Gm-Message-State: AOAM530efn2NxKUsx2ZSBc8fTXyxAVHmE/ynpw0z+49RUtRNZOiQ24EL
        SpvnGpJZRoB/UxqeasuA/WE=
X-Google-Smtp-Source: ABdhPJwyIwyiJ9dymi6xSPe25xa8jqxz0WtXJG0SkvVTc5lKjGBTvNziN9cbMXqnQb0BLkiepzIY3Q==
X-Received: by 2002:a37:4a56:: with SMTP id x83mr22925069qka.205.1614025040150;
        Mon, 22 Feb 2021 12:17:20 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id g21sm11442639qtv.68.2021.02.22.12.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 12:17:19 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Mon, 22 Feb 2021 15:16:59 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
cc:     dwagner@suse.de, "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: Re: [rteval PATCH 1/2] rteval: cyclictest.py: Make 'model name'
 optional
In-Reply-To: <20210126021241.112944-2-punit1.agrawal@toshiba.co.jp>
Message-ID: <291eb74f-aa88-4aee-f49e-201ef2e1bbd6@redhat.com>
References: <20210126021241.112944-1-punit1.agrawal@toshiba.co.jp> <20210126021241.112944-2-punit1.agrawal@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 26 Jan 2021, Punit Agrawal wrote:

> Certain architectures such as arm64 don't have a "model name" in
> /proc/cpuinfo. Relax the requirement to include the model name in the
> description to allow running rteval on such machines.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/modules/measurement/cyclictest.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index 232bd6b..afe87f7 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -217,13 +217,13 @@ class Cyclictest(rtevalModulePrototype):
>          for core in self.__cpus:
>              self.__cyclicdata[core] = RunData(core, 'core', self.__priority,
>                                                logfnc=self._log)
> -            self.__cyclicdata[core].description = info[core]['model name']
> +            self.__cyclicdata[core].description = info[core].get('model name', '')
>  
>          # Create a RunData object for the overall system
>          self.__cyclicdata['system'] = RunData('system',
>                                                'system', self.__priority,
>                                                logfnc=self._log)
> -        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + info['0']['model name']
> +        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + info['0'].get('model name', '')
>  
>          if self.__sparse:
>              self._log(Log.DEBUG, "system using %d cpu cores" % self.__numcores)
> -- 
> 2.29.2
> 
> 

Conceptually this is okay. Maybe we should set a default name of 'unknown' 
instead of an empty string? Also could you please log the situation when 
it occurs - perhaps INFO level?

Thanks

John
