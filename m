Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCF3C7EE2F
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Jun 2023 19:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjFLTAb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjFLTAa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2023 15:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E86E7B
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2023 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686596391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c9VA8lqPLv3C/ebsM0wX6c+i+nfOBnQcvzmFEEseK8Q=;
        b=ck6k5QUmiTh40f0xIxtflBSpnGk0wXVvFZ169NEveuRrHhuwr9ULEdAMIcLQST1WbEJe2c
        bPatxPR8pa07zjU92C2oc2QfBjH6SJrqb0pAtAW18vByPgmnsWudEKABTPOjvS42/rIqVj
        Mf7PyTf3AEBndz6FlJiCbNHIaA/u89k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-oH5ua5HSOyqfw_ZYs6aYHA-1; Mon, 12 Jun 2023 14:59:49 -0400
X-MC-Unique: oH5ua5HSOyqfw_ZYs6aYHA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75d4d5eda29so23939385a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2023 11:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686596389; x=1689188389;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9VA8lqPLv3C/ebsM0wX6c+i+nfOBnQcvzmFEEseK8Q=;
        b=BBlC/kZQVK2Z5JPfy5AIT7MsERFH6ckGEXbnDKPYo45uDNTGyU6DuZ05pBHGOv5rBR
         +PaWhjTQRY5mgB6urZ7bPbZp1S0xGKvExZfndgq//gH3zqcNNMzTlZWFwbYIFbF2nvog
         G28SX1dCzDI5yFIza9Me7A+8Jnozb0rs//NactRcH3DMOLLgJ2b9gnr0UVxwh34Xu9Uj
         mGFhG2IX+AHwWtNCxZMw0XuAhdzOrQBOi/ANvkGqRBY8MFLcKqEHF/UOfLusQGHGhciE
         vlRdjfWEdTZ2MNM7JELnl3R8e9LG8rvPEUPCJDDNpH2tdUUSM4NJcVt20dj7LnVRUR4R
         b4DQ==
X-Gm-Message-State: AC+VfDwKsPv3i6ZsJLGi3Gztf0nUOMRIK7Fk4ODUkatTNcyRtbXDpHQ6
        axIEF/mYOJywws72fcFQbK6aGISr7Ye06Sz3HtkQIclFEk6AaI/5dBLfCrzJ3qHeI+w+Kx4h8XK
        SYtvNa8thow3Bm8VNCYCePN9lmCtlSrjIq0w=
X-Received: by 2002:a05:620a:1d04:b0:75d:6b8e:b26c with SMTP id dl4-20020a05620a1d0400b0075d6b8eb26cmr11628644qkb.22.1686596389363;
        Mon, 12 Jun 2023 11:59:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51ou7cX4cd8FWa756Z7wQSMg0yzMlbK1ZtKCabfZbQt6H7tZaIbVxN6YdzodGLk4ZUBpIZig==
X-Received: by 2002:a05:620a:1d04:b0:75d:6b8e:b26c with SMTP id dl4-20020a05620a1d0400b0075d6b8eb26cmr11628632qkb.22.1686596389097;
        Mon, 12 Jun 2023 11:59:49 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9f80c000000b007578b6d060bsm233579qkh.126.2023.06.12.11.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:59:48 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:59:48 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 08/10] rteval: Use f-strings in tools.py
In-Reply-To: <20230601202734.813515-9-ashelat@redhat.com>
Message-ID: <f5cb51f-1dc7-ce4-f5a9-3a3563e5b851@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com> <20230601202734.813515-9-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 1 Jun 2023, Anubhav Shelat wrote:

> Use f-strings in tools.py
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/sysinfo/tools.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rteval/sysinfo/tools.py b/rteval/sysinfo/tools.py
> index 3993da413d8a..aa00b3d3eafc 100644
> --- a/rteval/sysinfo/tools.py
> +++ b/rteval/sysinfo/tools.py
> @@ -40,5 +40,5 @@ def getcmdpath(which):
>                  pathSave[which] = cmdfile
>                  break
>          if not pathSave[which]:
> -            raise RuntimeError("Command '%s' is unknown on this system" % which)
> +            raise RuntimeError(f"Command '{which}' is unknown on this system")
>      return pathSave[which]
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

