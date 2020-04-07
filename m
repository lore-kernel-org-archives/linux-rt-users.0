Return-Path: <SRS0=ghNa=5X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821CBC2BA2B
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Apr 2020 14:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEFC20857
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Apr 2020 14:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbxMJv/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgDGOza (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:55:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44727 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgDGOz3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Apr 2020 10:55:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id j4so1884033qkc.11
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Apr 2020 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1AbxhIkP5gINrWMXliefGdLZ9TqkK/YByIiz/Pgu4TQ=;
        b=LbxMJv/uQMbtlIczNUKMFPoEZaGDQc5pbDwT9snpYi/37yoZdxor339kY8DEHkh1+1
         sTEyrPt1fHdNWvqopC3AsOLkCyv7kme56d+2NHWvx/jeFayZRxvQbgiRRrXPWa1FmzLq
         Bo2+daSgCVrDqSvMZVpe7DRP9P2iD4FAuUVCJyvCA3XnhNDC6YFB65HBIfn9j7gUSHj5
         mMNRJTYQew6cf3Pw9pje0K/w5dPClFUdOvZDuQ8qgwkpzJJQsaFgHjnGXRK5puiu+pdV
         hSmYOUm/bvdd2+0Mx2I2DjxcSxO5kWwiuwFOMJF21Mqsn/8puzZyHRto894oUb5exjQl
         BsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=1AbxhIkP5gINrWMXliefGdLZ9TqkK/YByIiz/Pgu4TQ=;
        b=qkfUML4Tv9zt0e4qrJgr5Tm1qx6itDlJnPMhrMJvbwaU3B4dQQeAkv0gwSs24ejLrU
         XFEs0EY78Las62fOkzxBhMRJhM7PBbFymmyaVyc6WI91EoRx1KJSYw1PQecaVBceK8ei
         0/4KBkbM1Vdg4hCx2czOUejnJsOfijJ4hoQskXu0MLIBM2FBEqorMZKZXuKLMY98Fprf
         9r12bjr7t7G+r1l4pZjaH5FaExewqFcbM1kU85enxdym7lmtSufWPl4UWNqQJIKbw695
         zxh3oamy0nLti2OAIk0NX7pJ+qmUDMj8cFKJduQhrnTrAct0gXhlQy1W9UFWCfcsgiQz
         fkkw==
X-Gm-Message-State: AGi0PuaJUhHsMjcKWCzbRpeAB4H/lMoTZ8f8IaypPGxXk/vo/V31uChP
        i1Mf8SvG9PSltbB1okffJnw=
X-Google-Smtp-Source: APiQypLttX3BbJvtJhZERwyopVFzg/RUSSFqhPNW6yzxnHHBg3aXeUg/E7pY5VLgrs/HytCQtMyQzQ==
X-Received: by 2002:a05:620a:12bc:: with SMTP id x28mr2574400qki.175.1586271328648;
        Tue, 07 Apr 2020 07:55:28 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id m26sm3878061qta.53.2020.04.07.07.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:55:28 -0700 (PDT)
Date:   Tue, 7 Apr 2020 10:55:21 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Scott Wood <swood@redhat.com>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RTEVAL PATCH 3/3] modules: Don't abort if a workload isn't
 running
In-Reply-To: <20200406221405.3043-3-swood@redhat.com>
Message-ID: <alpine.LFD.2.21.2004071054560.6907@planxty>
References: <20200406221405.3043-1-swood@redhat.com> <20200406221405.3043-3-swood@redhat.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 6 Apr 2020, Scott Wood wrote:

> Each module is responsible for respawning the load when it finishes.  The
> only thing that the additional check at the rtevalModulePrototype level
> accomplishes is introducing a race condition that will kill rteval if a
> load ends after _WorkloadTask() checks, but before the check in the
> caller.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  rteval/modules/__init__.py | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
> index 0feb8a916179..5ae7cd488406 100644
> --- a/rteval/modules/__init__.py
> +++ b/rteval/modules/__init__.py
> @@ -189,9 +189,6 @@ class rtevalModulePrototype(threading.Thread):
>  
>                  if self.shouldStop():
>                      break
> -                if not self.WorkloadAlive():
> -                    self._log(Log.DEBUG, "%s workload stopped running." % self._module_type)
> -                    break
>                  time.sleep(self.__sleeptime)
>  
>              self.__timestamps["runloop_stop"] = datetime.now()
> -- 
> 2.18.2
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
