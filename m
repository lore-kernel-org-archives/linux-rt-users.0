Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC5AC41513
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jul 2023 16:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjGZQtB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jul 2023 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjGZQsq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jul 2023 12:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB122691
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690390079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mmJ3JGo6ep3Oh/kPX8lKcZMk1OGoausSTZP2WMpDsZE=;
        b=fCysfCXpTO/JK8G4C2K3pG4xhDz3JyH0auDU/C9zAZgCVXXgME0d3ad8Y8MHQnQOSv00SJ
        kGfQnnI+c2VxiDCH3L1jktI+Ng/fJSOOmg94+LdtiSI80Wg1EwvbyuLo8js6awYfkqlZdV
        Q7Gf4apv+e5UbnTcnMCUmX3KxQ58ppw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-wv3yBHZ4NmWacricsPaFlQ-1; Wed, 26 Jul 2023 12:47:52 -0400
X-MC-Unique: wv3yBHZ4NmWacricsPaFlQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63cf9d48006so545976d6.1
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 09:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690390072; x=1690994872;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmJ3JGo6ep3Oh/kPX8lKcZMk1OGoausSTZP2WMpDsZE=;
        b=lSzXTCf1+NwgWfxKQWOm/yTtanFO1YTUf+trDup0TXZZafIg6uEdmRFZ+51R4bOwVI
         /L4WGcqvlQqKHtOIz+nqOw52JSJBJg9Htzl3J3Z92RzJv3jmqLr4j9JefBY5UcxIyKGe
         N7gzrdCq1Ny6m2GUkLoQLaUu5FgU9lFjV0oJtON9auop+oYuBIko8GZbf1FIn2jwZ9qk
         +ODEsHcwWujZqqkM6L0XJU3VVbBswHP2I4eIchWMY+PGMFFO2PtDJABDPkTSEtclP1H4
         RMZxmPZJBVPH5AfGX/6BIfqzz0dM4mgJmSgaXZDYFtQApwgIgCBLsanV1ary5odXP0Gx
         dLZw==
X-Gm-Message-State: ABy/qLbhCPUzRlGEUzeel7l/E5CPbRBwFr3tfHj62oCwlUn070ouT0ie
        cr15rc7nGXXE3oVjROgDwJayuBHHQy7100fXhUG7XNAPKo8+E5kS8RoZXQONcm2hKw3B2iONTm3
        wleWB9uoXcEnS7jLJWm0jsW3/CbA=
X-Received: by 2002:ad4:52c5:0:b0:635:f48d:5b7a with SMTP id p5-20020ad452c5000000b00635f48d5b7amr2302962qvs.23.1690390072316;
        Wed, 26 Jul 2023 09:47:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFMAXHibYb6przzaSK+rQswhaQCPJtt1b3x4VOKOWtOGtzo0b9tiQ+7HwP5tkZD8dZ+Nh4GBw==
X-Received: by 2002:ad4:52c5:0:b0:635:f48d:5b7a with SMTP id p5-20020ad452c5000000b00635f48d5b7amr2302952qvs.23.1690390072003;
        Wed, 26 Jul 2023 09:47:52 -0700 (PDT)
Received: from fionn ([184.147.142.236])
        by smtp.gmail.com with ESMTPSA id l26-20020a0c979a000000b0063d2a70dff5sm561536qvd.72.2023.07.26.09.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:47:51 -0700 (PDT)
Date:   Wed, 26 Jul 2023 12:47:42 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH 1/5] bitmasklist_test: Added SPDX licence
In-Reply-To: <20230726144826.355643-2-ashelat@redhat.com>
Message-ID: <838ba9bf-c158-c3e5-9da0-f2aa89fccd60@redhat.com>
References: <20230726144826.355643-1-ashelat@redhat.com> <20230726144826.355643-2-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 26 Jul 2023, Anubhav Shelat wrote:

> bitmasklist_test: Added SPDX licence
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  bitmasklist_test.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/bitmasklist_test.py b/bitmasklist_test.py
> index 677c84a9504f..16169af52bfd 100755
> --- a/bitmasklist_test.py
> +++ b/bitmasklist_test.py
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
>  #!/usr/bin/python3
>  
>  """ Module to test bitmasklist functionality """
> -- 
> 2.39.3
> 
> 

Did you try running this?
The shebang (#!) must always be the first thing in a script

John

