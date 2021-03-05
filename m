Return-Path: <SRS0=Pnk0=ID=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB263C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 15:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE40165015
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 15:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCEPaM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhCEP3u (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 10:29:50 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CB5C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Mar 2021 07:29:50 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id t13so604339qta.11
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Mar 2021 07:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ctJXqH3QtQvGY/DQ5K5vhAZsDbPiNSk5meQRPq1X64o=;
        b=ISGuBuPIxz1i+nBU80hva+u1gPsoZgdanuFYFnNDGHL9xwEyN5cAff5e7fixPOaGPh
         eaIka9dcmO/EAxjt/NrvKeIXcwgw7HSFS5McmCRv51S7repmz1sFSRPQXoVIeoh5xt/t
         W9g66bTh8zr1WrwWlPla4LG2dzok1LYdwjkoiqWpJJ/rkERDVFatqQnhx3UNiZ1SRY/g
         He9MBmjErEdvqouOavlrncUdMcet4W9XuqRA/kE6bJiEcECuHa1ZWObztMEXlfVViRw+
         n5QCDbIDurUNwNI7gBHNABU8OuYP5xVUaB3V4W7E3v5T58fHOM294OcElMl7pttm0qXZ
         /A9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=ctJXqH3QtQvGY/DQ5K5vhAZsDbPiNSk5meQRPq1X64o=;
        b=dYJ7lUsnk27NnzSJ+vsGKwltMWjjt/ZO1Ca9yEC0NArXVWhePklsCRJP+ogRgDhN0W
         S3j+DL2DDc2ZEOakigSPVyms1/ohDfkKfci4zIxjK0EeGZV1Lms6R76dAf2FWW8pbGzX
         ydVIUSXy9yaYb3H5uINYETKlnDfUY/cCM/3I2b3STk+nmG6PtPhF+P3Esjb1Abdp3XTH
         f3AkngLB1pTGGgNHwuVS2SafrcVMXCIdjihvC8yWTOSKJmup9/xUkyTPfN7TwqY0/qKY
         pCiFaXUJazw45e9MaHvuYJIQjoJPTulnIKVEzSV9XHPAXoeBGleO3sDMnoh8ECc56KEP
         eb5Q==
X-Gm-Message-State: AOAM533GuGKjOu0gF/pNYdna7EpWVxyyvwnbCXTpk82X1GvZ97pH61VH
        ODBP1SFxvuwKVRYAn1J3WYlwPyMS0OXsEw==
X-Google-Smtp-Source: ABdhPJz+MHS2DGlshBXr0hrYM+8U1m/L/E6neOenNILE6AA2ZG1vkwEjlzOhvQeanQPXQV4vTf+Mow==
X-Received: by 2002:a05:622a:44d:: with SMTP id o13mr9189947qtx.378.1614958189351;
        Fri, 05 Mar 2021 07:29:49 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id s2sm2117164qti.54.2021.03.05.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:29:49 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 5 Mar 2021 10:29:41 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v2 00/14] JSON cleanups and more tests updated
In-Reply-To: <20210305074138.lobxlbt7sirtj7lb@beryllium.lan>
Message-ID: <bc668ca5-2f1b-fc36-4aa6-36917d0b6a@redhat.com>
References: <20210305073500.17926-1-dwagner@suse.de> <20210305074138.lobxlbt7sirtj7lb@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 5 Mar 2021, Daniel Wagner wrote:

> Hi John,
> 
> On Fri, Mar 05, 2021 at 08:34:46AM +0100, Daniel Wagner wrote:
> > v2:
> >   - added 'return_code' to the common section of the JSON output
> >   - dropped 'inversion' as we have 'return_code' in pip_stress
> >   - dropped 'success' as we have 'return code in ssdd
> 
> I am pretty happy with the this version now. That means I don't plan to
> change more on the JSON feature. Well, one thing I am still not really
> happy is the name '--output'. But as no one had any better idea, let's
> keep it as it is. Hopefully no one wants it changed in 2 weeks from now
> :)
> 
> So if you want to do a release, please go ahead.
> 
> Thanks,
> Daniel
> 

How about --json ?
Description, "Optionally output final results to FILENAME in JSON format"

John
