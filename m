Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C84EC433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 12:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AD060F6C
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 12:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbhIMMim (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 08:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238877AbhIMMik (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 08:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631536644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDeHHXy+f9YhgWMphqAl4Xs+MojRZ9VVJrwem5PZG1E=;
        b=OB1ydemKpUSEgAPg68gGzZPdyvY1JHtX9tM1f2Xlc4YoumI/qc2KEOOoAp28CSlHbw1JM+
        Gl1ktJ2/2cAZwsjb3WDcKLTxTLt32r18akNK3P28OGTy2bsYuytNmk+6AtFFp5SClzN/DW
        FtduUBdPjBf4DwfJHbfvFT3rsXfUgRY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-joTG22_QM8-XuRkk-rj2VQ-1; Mon, 13 Sep 2021 08:37:23 -0400
X-MC-Unique: joTG22_QM8-XuRkk-rj2VQ-1
Received: by mail-il1-f197.google.com with SMTP id o12-20020a92dacc000000b00224baf7b16fso15492213ilq.12
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 05:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=pDeHHXy+f9YhgWMphqAl4Xs+MojRZ9VVJrwem5PZG1E=;
        b=NGc1RZupAfjiA3WoHfnKSrBaj8ztKA6jBcBoLyL4Pr8pXTQm1yiCvp+Qg6eK2RN8FJ
         FwsuEgro+aaPB4TrP4Xw1kFaMbeBIcAZXizNShnxloGHu7SQ3Kq4Ddducx33XobWywa3
         Hs0+ruo3uy717t1qsxkhwSBgQjjRyzbPGUAlWgX5YT0oJB8/McyntZHdSppEkWkhhKnr
         oADys24xBoznB4SGLE1NKZXz7FcqzCposHGOD9yeYcOmUE6UArhnCL+4HsFmKw++U9iD
         cek/kmqSQqonFOi5gNHEdBQ1DFtYizMkQZ6buTnVEVVp5oijs1/NrmE4FPxOKCX0cIgK
         BBPA==
X-Gm-Message-State: AOAM532DDJRGIayu+3KQZbitpWlbV283jox11We6hKIAbaNfcaoYdATv
        y43ZJPM3BDJsT8vTj39UNdGgQCQLPgswSkn1pj4p/DRmeJ4BL3YIHwl1E/AbqhGNlg/s/IW0jaH
        GeDNX/iT99MTabEzXOpSbv6h+B7M=
X-Received: by 2002:a92:dc85:: with SMTP id c5mr7843749iln.104.1631536642441;
        Mon, 13 Sep 2021 05:37:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/aEztb5VprM4Kk93+Iahjonj5YErYwF5+LTMoxYcSmVZojYAeyvvUWGbNgkOAU7OfuPbGXQ==
X-Received: by 2002:a92:dc85:: with SMTP id c5mr7843733iln.104.1631536642180;
        Mon, 13 Sep 2021 05:37:22 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id i14sm4412547iog.47.2021.09.13.05.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 05:37:21 -0700 (PDT)
Date:   Mon, 13 Sep 2021 08:37:20 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     Clark Williams <williams@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: Re: [PATCH 2/5 V2] rteval: Construct a 'model name' on architectures
 that don't have one
In-Reply-To: <87tuip9oea.fsf@stealth>
Message-ID: <618d5d5d-4215-adaf-692b-e18fc7c4d5b@redhat.com>
References: <20210912154538.255217-1-jkacur@redhat.com> <87tuip9oea.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 13 Sep 2021, Punit Agrawal wrote:

> Hi John,
> 
> John Kacur <jkacur@redhat.com> writes:
> 
> > This is based on an idea from Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >
> > On architectures that lack 'model name' in /proc/cpuinfo
> > create 'model name' Unknown when creating the per core dictionaries
> > in cpuinfo
> >
> > For arm, we can construct the 'model name' from the
> > 'CPU implementer'
> > 'CPU architecture'
> > 'CPU variant'
> > 'CPU part'
> > 'CPU revision'
> >
> > Suggested-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > ---
> >  rteval/misc.py | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/rteval/misc.py b/rteval/misc.py
> > index 0dd361ff19fd..c1d2a972430d 100644
> > --- a/rteval/misc.py
> > +++ b/rteval/misc.py
> > @@ -77,6 +77,27 @@ def cpuinfo():
> >              info[core] = {}
> >              continue
> >          info[core][key] = val
> > +
> > +    for (core, pcdict) in info.items():
> > +        if not 'model name' in pcdict:
> > +            # On Arm CPU implementer is present
> > +            # Construct the model_name from the following fields
> > +            if 'CPU implementer' in pcdict:
> > +                model_name = [pcdict.get('CPU implementer')]
> > +                model_name.append(pcdict.get('CPU architecture'))
> > +                model_name.append(pcdict.get('CPU variant'))
> > +                model_name.append(pcdict.get('CPU part'))
> > +                model_name.append(pcdict.get('CPU revision', ''))
> 
> Is there a reason to use an empty default for "CPU revision" but not for
> the other components? Maybe a left-over from original patch.

Not sure of the origin of that typo, but thanks for catching it, removing.

> 
> > +
> > +                # If a list item is None, remove it
> > +                model_name = [name for name in model_name if name]
> > +
> > +                # Convert the model_name list into a string
> > +                model_name = " ".join(model_name)
> > +                pcdict['model name'] = model_name
> > +            else:
> > +                pcdict['model name'] = 'Unknown'
> > +
> >      return info
> >  
> >  if __name__ == "__main__":
> 
> With the above comment addressed, fwiw -
> 
> Reviewed-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> Tested-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> Thanks,
> Punit
> 

