Return-Path: <SRS0=gxMZ=CN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C57EC2BB84
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Sep 2020 15:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0116206B7
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Sep 2020 15:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh047V46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIDPke (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgIDPka (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Sep 2020 11:40:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E26BC061244
        for <linux-rt-users@vger.kernel.org>; Fri,  4 Sep 2020 08:40:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b14so6689214qkn.4
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Sep 2020 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=YggbuaEqcMFtIBHk9evv3AlYs99h+axasfIj7qo2qZI=;
        b=Rh047V46g8CxrHqptcicwqSw/Y+Z13ABnrEzRuoyczbafCWUaX2tQ5gGjU40RMqpaz
         RLzKO51r4qzc6Y2vxKTrDsIk/esUtPXk/q3nE8BLeOJuN2iaopnWzyQ+2kYN92eJVbt5
         NxsMgH237qyDvCMzFEWskIaYIuJanVx6ZJtUSgORtAGwWoUJHKmKHXRhiRTfRLuvzUEJ
         AkwyUVCGqrhk4poiw8UeLoaFUKRByIEFHKXH9smxdoBqXR3dVcZWXOLKANm/Y/Px7bWV
         HxQP8pnzWj917WzxFXTIwtGfFM2gYLfr/RMJhibqhrzghgJmEIamAtLhmjVEmgrzAQlr
         PkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=YggbuaEqcMFtIBHk9evv3AlYs99h+axasfIj7qo2qZI=;
        b=qq6t58pWxaRpwbu+4mOJQYR5BoCpCaarKQsnv6k0fXeYxMGNdn5dtlx0+wKzTmPa8o
         QKILbgf33VvXnDBerBzq7E4224XwzcCT0UC71DN3RAgvZJGHOcTrwGsnXoF5QfFM8PDa
         GTtTlvp+g0wUNdSaJBQk4qjyofOBHnScgasfPGCzxI0p+B495uK/LalVyVgNfzR2lvr6
         5B3xbKwMroY1mUELwJM10oxvHL3/1M8mfMDyL0qYXvkWGcMvVemd2PFOcROm0ZyNkU5O
         Uenacd46f19taCG9l3/3zh0ehnM6ESObz0GjXy6ETekQn9n2/xJyI/KdgyCOa2F8nFqP
         OiMw==
X-Gm-Message-State: AOAM533G6KqO0Zsdni95SqnvabI/Wmc4LGFPRP+/zcvk/Hz305R1Zgom
        /pQ0QRP4inazWUU4ffQh3ss=
X-Google-Smtp-Source: ABdhPJzpWQFlSwL+NUmfXRV4bBRDLrUx9ng7hiv8i4sw9znjzpybaI3SFMOU21AEjDq25gDuHmhvmg==
X-Received: by 2002:a05:620a:13f6:: with SMTP id h22mr8797164qkl.9.1599234028343;
        Fri, 04 Sep 2020 08:40:28 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-180.dsl.bell.ca. [184.147.140.180])
        by smtp.gmail.com with ESMTPSA id d47sm4869637qta.63.2020.09.04.08.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:40:27 -0700 (PDT)
Date:   Fri, 4 Sep 2020 11:40:06 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@fionn
To:     Daniel Wagner <wagi@monom.org>
cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests 0/4] Streamlining code base?
In-Reply-To: <20200904063123.uu37gp4ipom64ao6@beryllium.lan>
Message-ID: <alpine.LFD.2.23.451.2009041112370.4562@fionn>
References: <20200902082725.20037-1-dwagner@suse.de> <20200903203948.4d2e5370@tagon> <20200904063123.uu37gp4ipom64ao6@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 4 Sep 2020, Daniel Wagner wrote:

> On Thu, Sep 03, 2020 at 08:39:48PM -0500, Clark Williams wrote:
> > I think it's a noble goal and I'd be up for it, especially trying to come
> > up with a parsable output format. Got any thoughts on it? Personally I'd 
> > go for (in order of preference): 
> > 
> > 	XML
> > 	JSON
> > 	Random Gibberish
> > 	Any Damned thing
> > 	YAML
> 
> For jitterdebugger I ended up adding a bunch of plugins for the output
> format. So I don't have to argue which format it best, though if I had
> to choose I'd properly pick JSON.
> 
> > Did I mention that I hate YAML?
> 
> Named must be your fear before banish it you can.
> 

We have some software called rteval that parses the output of cyclictest.
https://git.kernel.org/pub/scm/utils/rteval/rteval.git/

(I'll take patches for that too)

It runs cyclictest under-the-covers like this
cyclictest  -qmu -h 2000 -p95 -t -a
and parses the output.

The output is then transformed into XML.

What I like about this, is that it keeps cyclictest lightweight since the 
data it parses is just text. Then rteval could generate whatever kind of 
output you are interested in. xml for clark, yaml for the yammering crowd 
and so on.

I'm not saying this is the only legitimate approach, but I would like to 
keep the individual tools lightweight in rt-tests, so that you could run 
them individually in the embedded space as well as on large machines.

So one way to start would be to make sure that the other tools in the 
rt-tests suite are capable of generating a similar kind of output, that 
could then be processed by other tools.

John
