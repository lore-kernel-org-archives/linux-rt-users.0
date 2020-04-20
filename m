Return-Path: <SRS0=MBx+=6E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58B4C54FCF
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Apr 2020 18:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DE72071C
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Apr 2020 18:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3A7HWXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgDTSio (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:38:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39847 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726825AbgDTSin (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Apr 2020 14:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587407922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nn0H7bEuwLkn9EYwnqa9XbAdRyVqZTz7T4mh9M23lKc=;
        b=M3A7HWXbE/+n/dwoWfQ6z0tYyA0NRmu4iy5+57pl1f9nyEyap/pHmypGFqiycnBSUaSywy
        hqRCJbHRFypqHg7oMsadu5BJRr6N8lizKxj3rhAyC/4zfTu1TC+ty6kO2/GAeNKrhDkZ7B
        zfj9e0UfjevzJjsRytpdu4/MHidbFn8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-odvNOALoPjekGbilXYMlag-1; Mon, 20 Apr 2020 14:38:39 -0400
X-MC-Unique: odvNOALoPjekGbilXYMlag-1
Received: by mail-qk1-f200.google.com with SMTP id x5so11347567qkn.20
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2020 11:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Nn0H7bEuwLkn9EYwnqa9XbAdRyVqZTz7T4mh9M23lKc=;
        b=C4eQI7lVspBaYrZsQ170Iv+tegdqrS9Rn+9yWPr7CS3dpWNCOw8IMXpu6N7JfF9dJz
         rGnVKZ+HA8GHjviGju629b44o2ouQJuus7Q6t/Ka1OA8mNE0oh77kmgrQTrpxiS9wTeH
         c7pzkiI/pdbOTgDe+g37CEX45zOtSz3zeJhC0C9s4ePBNFQ8pHnhCYowPa6H283F6CcN
         BxmP+6GNyTeJPjr7jkToxfIZGvlW43VgUAwc5OnZsl4h9dggJ4J757fTinQbKeXRl2Mb
         TT3EmFhuwqBRQ7DE492M/R/mhh/M8TYRNew++6T88VUaWR0yfyWmIwNw9ba4U3ebqXy/
         Drqg==
X-Gm-Message-State: AGi0PuZlID8zdLWzUFyqQ4SPz1EMVwZ15lMoesxOalM4gYRjWk6uI1Y1
        dzwu1mWrx5RuKXFhOYHQ6evC09jU71JpsSG13KWqbff/QKhTo1RfsGlpkBmQphX1UmpaaQBlNpB
        BUM/zbh2qvHPoN/7ATJ54RdHHrB4=
X-Received: by 2002:a05:6214:885:: with SMTP id cz5mr16756260qvb.43.1587407918437;
        Mon, 20 Apr 2020 11:38:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypIAPl29KD06eTAiSyB7GVK95Q1RztWyjhIrhjXNXKsvcN/IJHPn/laUX3Zx5Zr95ZE6jQ/vhQ==
X-Received: by 2002:a05:6214:885:: with SMTP id cz5mr16756239qvb.43.1587407918227;
        Mon, 20 Apr 2020 11:38:38 -0700 (PDT)
Received: from trix.remote.csb ([75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 65sm234506qkf.79.2020.04.20.11.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 11:38:37 -0700 (PDT)
Subject: Re: [PATCH v2] Import a new test, jitterz
To:     John Kacur <jkacur@redhat.com>
Cc:     williams@redhat.com, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
References: <20200418141449.19293-1-trix@redhat.com>
 <alpine.LFD.2.21.2004201255350.4545@planxty>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d4ddb418-c1ad-b468-1ec8-604676c18284@redhat.com>
Date:   Mon, 20 Apr 2020 11:38:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.2004201255350.4545@planxty>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John,
>> + *
>> + * Copyright 2019-2020 Tom Rix <trix@redhat.com>
>> + *
>> + */
> Should the manpage mention that the original idea comes from sysjitter?
> While I'm asking that, just to play devil's advocate, why are we not just
> forking sysjitter and adapting it to our needs? What advantage to we get
> by re-implemnting this?

sysjitter is not a well known nor a well supported tool, the attribution in the commit log is enough.

jitterz was started because of limitations in sysjitter. So the effort would be to fork and address those limitations and upstream.

Tom

