Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC76C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Apr 2022 15:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357001AbiDLPX1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 11:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbiDLPXX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Apr 2022 11:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C493619C08
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Apr 2022 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649776864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rm+hOtkumy+5HJyypwGo6/3oh43nx3VrOF5eS4iFkys=;
        b=CDmkrR1QAjdGuwocsFrk7lXQgpFVTlEMTDGzucaL8anYtOTAW3RDe0s0jvNGLAq6iKWhuj
        Nc/X2pkI4DBrZrC6dZ0qnZ8IO91fv1nh/5iT06yZoy2+8TNR4hnnYvReAR0BCZa3i/dv78
        Di1jJC+qvGgbuzexvkjXvRyJSxnVC6M=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-vyh5FqMUMBC2-pQF1sDS2w-1; Tue, 12 Apr 2022 11:20:56 -0400
X-MC-Unique: vyh5FqMUMBC2-pQF1sDS2w-1
Received: by mail-io1-f69.google.com with SMTP id y4-20020a6bd804000000b0064c68fa4f70so11804668iob.2
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Apr 2022 08:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rm+hOtkumy+5HJyypwGo6/3oh43nx3VrOF5eS4iFkys=;
        b=G3pesihjRFbVf6fH/oq2zkd5za7i0NctHv+1MIHoLiNnc3GA0SSbiOBSlpKjiPNn3M
         Ko0dLd1rEB+sKp4nj1ELG5MGGqLu5iuFi554QueC8ZyjgFkCZSs592B1kYOe1FvLsdxL
         TqUgKn3aee89o85GDc36S10eAUqD9o9S4OTQhs2XuKZJ3ado3EkX2uI/2Imdb/2M3NpG
         o+ByJDtnuQ8jUOZCOm9Bwhu6rQ8doYJqSSDhVLoggYEvqQUMT3lkRqaT8bim5VyAVHR4
         qFNxfUlLck9/SoViGAHfqSE5Bieeg2eLYXrD7G13gsS4dxyj/oR2ziLmGRRFLosts60x
         a/Dg==
X-Gm-Message-State: AOAM533x/EtEx3iyaEpBeNIJ9W3xFhOe1BFXPXCMUp/jNeClTwAZp5Sd
        K/h9amKGqUkdHA/tCevr6GuqLm8uIW05QWgg1cyOSHazLoOs+oK94Omtqm8SCjmMfaXFbosLeTR
        NwoANa7MnIhsN8ShcWPpBGBQYJWQ=
X-Received: by 2002:a05:6e02:ece:b0:2ca:1b6b:6180 with SMTP id i14-20020a056e020ece00b002ca1b6b6180mr16343683ilk.316.1649776855642;
        Tue, 12 Apr 2022 08:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxsoJP5fxiupEdteQjmgvH0LiedcMuAa+9eytgXTVrXRkdTJ5MQEs6lzobOvt7OuzHCQD31Q==
X-Received: by 2002:a05:6e02:ece:b0:2ca:1b6b:6180 with SMTP id i14-20020a056e020ece00b002ca1b6b6180mr16343674ilk.316.1649776855425;
        Tue, 12 Apr 2022 08:20:55 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id a9-20020a92c709000000b002ca50b388f0sm14737687ilp.40.2022.04.12.08.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:20:55 -0700 (PDT)
Date:   Tue, 12 Apr 2022 11:20:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH] oslat: Print offending cpu number when above threshold
Message-ID: <YlWY1gK6AN1xPmG1@xz-m1.local>
References: <20220412135518.531234-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220412135518.531234-1-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Apr 12, 2022 at 03:55:18PM +0200, Nicolas Saenz Julienne wrote:
> Knowing which CPU went above the trace threshold is useful information,
> even when not tracing. So let's print it.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

