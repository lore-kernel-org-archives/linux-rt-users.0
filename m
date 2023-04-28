Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F77C77B60
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Apr 2023 21:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjD1Vhk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 17:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjD1Vhk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Apr 2023 17:37:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9AF26AF
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Apr 2023 14:37:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50a14564d17so21430880a12.0
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Apr 2023 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmn-com-au.20221208.gappssmtp.com; s=20221208; t=1682717857; x=1685309857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qEnE+cYpjYH/1q/a7QPJfyWy8nSriqqG7V5hDP+kiBU=;
        b=Q9uKxnnDZYwNlKq8mAHYD68W/1rIV9UE3vdGWePmKgmVYQ/yrEyK/dlDdNIPxp9utg
         axiDSuV/mv0/+8iQ6VApIuNs88X5MLsDIrbU4vk/RGPqunJEkVB6M3QAO+Gqwasxlgcm
         MvSNixEGpQEbBo9e/UrX2U2A9gTNEcKIiS9CbJrDyjJa7vbd+PQrWsuNG2FdpngcPC3f
         w/fMyK+39gPNrf33g/JD42l6hn2n+nGTU6ytwtGXlfvT3AaSbjwQdSlK03L901e+9iiu
         4SPOT3vFDW61/0tsHzQN2lVY5BQ1KqwLEOeHmi17kQMF7elmPEhOquz9iZwSqFbs0V8n
         oWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682717857; x=1685309857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEnE+cYpjYH/1q/a7QPJfyWy8nSriqqG7V5hDP+kiBU=;
        b=itEHNYo925INMGzKVxb1IBHYK+QjsyK3UeiADlpcB9yh0qhS29gZjvr+kdt3A/H0Nu
         cCVG4qW3d+5SUlMnfhFsne19LRSo2vrHo0q5sx5h7EtMPCq0kPRQCkjQ5Hg9sTQXTFPF
         5TB67e4KaJPOb2mo2+2Rqfx5Shelz8BsfIfq2Y7sf0ubbRnK9nlD8EkFO4bJzGWRqixm
         GtrINEpckX2GdvJN4ouqgefEwMWK9IMDlN6qbW6X2OZf6bHB6wXoE7zI90485mEB2Ycf
         wYmOqSUKwCwsveCZCWJYS+Tx70zGAAHKp3uiFodbzMLCBYYjgFza9U/fiosedaI7fZ9O
         PlBg==
X-Gm-Message-State: AC+VfDxvv7Pp0fe5bsoahQYn6BISkw01WByAfvYo9YlW+HGxLf3R1/hK
        2sEBstUNjnpuNgAlItM1zH0NqbY46w67nNpheo11Crw4q3Uhvim2xa+VcQ==
X-Google-Smtp-Source: ACHHUZ4iY6okVOKxYJL/8bLSYXf1nyLguMlDOCAJ5Ykq5X1WHVZN4KI1RUX2hdM/DppXtOhVbkkDxJZPYX/QjVO/3qU=
X-Received: by 2002:aa7:ca57:0:b0:505:43e9:6ff7 with SMTP id
 j23-20020aa7ca57000000b0050543e96ff7mr246639edt.7.1682717856990; Fri, 28 Apr
 2023 14:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <CANV1gkc9KvkGNPkEsjXCiV4mUcdrrPcaQ1ueRri9ypjvJbU94g@mail.gmail.com>
 <20230428085123.HX02J4Ym@linutronix.de> <CANV1gkcr4jBUY-iH-iJJPdrVMp+1Nq1YrNPONferMC1AutJgkg@mail.gmail.com>
 <20230428131236.9MfVxN3s@linutronix.de>
In-Reply-To: <20230428131236.9MfVxN3s@linutronix.de>
From:   Rod Webster <rod@vmn.com.au>
Date:   Sat, 29 Apr 2023 07:37:25 +1000
Message-ID: <CANV1gkdZWRu=g1yLBOC_=Y37H=9FEOHRCdAOBhf5j3+3T4_=qg@mail.gmail.com>
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al NIC
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001fb1c905fa6c483e"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--0000000000001fb1c905fa6c483e
Content-Type: text/plain; charset="UTF-8"

> Okay. Then it could be related to softirq rework which started in
> v5.0.19-rt11 and updated in v5.9-rc6-rt9.
v5.9 could also be significant as the R8125 driver support was added
in that version
I upgraded from Debian Buster to Bullseye (v5.10) on one PC for this reason.

> Are you able to recompile a kernel?
Yes,
I have attached a text file containing my 6.3 build steps.
Note we had to git pull the kernel source as it was not available via
http at that time
I have not tried with your 6.3-rc11 patch yet.

> However as per you Debian bug report v4.19-RT is fine, v5.10-RT isn't
> and v6.1-RT is better or is it fine?
I built v6.1-rc7-rt5 before Debian advanced to v6.1
It was reported to be an improvement and it solved the Debian latency
issue for some users.
v6.3 was reported as being as good as the 4.x kernes by our hardware vendor

> Where is the Intel ethernet coming from? You were saying it is the
> realtek nic.
Sorry, you mentioned coalesce but that's an Intel feature and does not
exist with Realtek.

> Is the vendor driver better than in the tree? This is not obvious from
> what you are writing.
I have been unable to compile the R8168 driver from source on the
Realtek website.
They are behind with supported kernels and the build process is
invariably broken for me.
On the Hardkernel Odroid forum, it has been reported that compilng the
R8125 from Realtek source offers 15-35% improvement over the in-tree
driver.
 I have one of their  PC's (H2+). It's currently running v5.10 and the
in-tree R8168 driver (which must be the Debian default).
 It is affected and I plan to upgrade to v6.3 with the R8125-dkms driver

> Two things you could do:
> - enabling tracing to see what is causing the delays/ latency spike. You
>   will need a trigger to notice the latency and then stop the trace at
>   this point. If so, I could provide additional steps unless you can do
>   it yourself.
Please advise additional steps to do this.
We might  be able to modify our hardware device driver to stop the
trace as it reports latency incursions if they occur.

> - You could try to isolate the realtek driver on one CPU and moving
>   everything else to another.
This sounds interesting. Please advise how.
On a 4 core machine we typically add isolcpus=2,3 for best RT performance.

Thanks for your support.

-end
-Rod Webster

--0000000000001fb1c905fa6c483e
Content-Type: text/plain; charset="UTF-8"; name="Instructions.txt"
Content-Disposition: attachment; filename="Instructions.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lh10ydt30>
X-Attachment-Id: f_lh10ydt30

77u/YXB0IHVwZGF0ZSANCnN1ZG8gYXB0IGluc3RhbGwgLXkgYnVpbGQtZXNzZW50aWFsIGJpbjg2
IGxpYm5jdXJzZXM1LWRldiBwa2ctY29uZmlnIGxpYnNzbC1kZXYgZHdhcnZlcyBiaXNvbiBmbGV4
IGdudXBnIGxpYmVsZi1kZXYgbGlic3NsLWRldiB3Z2V0IHF0YmFzZTUtZGV2IGRlYmhlbHBlciBy
c3luYyBnaXQNCm1rZGlyIHJ0bGludXggDQpjZCBydGxpbnV4IA0KZ2l0IGNsb25lIC1iIHY2LjMt
cmM1IC0tZGVwdGggMSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQgbGludXgtNi4zLXJjNSANCndnZXQgaHR0cHM6Ly9taXJy
b3JzLmVkZ2Uua2VybmVsLm9yZy9wdWIvbGludXgva2VybmVsL3Byb2plY3RzL3J0LzYuMy9wYXRj
aC02LjMtcmM1LXJ0OC5wYXRjaC5neiBndW56aXAgcGF0Y2gtNi4zLXJjNS1ydDgucGF0Y2guZ3og
DQpjcCBwYXRjaC02LjMtcmM1LXJ0OC5wYXRjaCBsaW51eC02LjMtcmM1IA0KY2QgbGludXgtNi4z
LXJjNSANCmNhdCBwYXRjaC02LjMtcmM1LXJ0OC5wYXRjaCB8IHBhdGNoIC1wMSANCm1ha2UgeGNv
bmZpZyANCiNTZXQgdGhlIGZvbGxvd2luZzogR2VuZXJhbCBTZXR0aW5ncy9QcmVlbXB0aW9uIG1v
ZGVsID0gRnVsbHkgUHJlZW1wdGlibGUgS2VybmVsDQojU2F2ZSB0aGVuIGV4aXQgKENsaWNrIG9u
IEdlbmVyYWwgc2V0dGluZ3MgYW5kIHNlbGVjdCBvcHRpb24gb24gdGhlIHJpZ2h0IHNpZGUuDQoN
Cg0KIyBUaGVzZSBrZXlzIG92ZXJyaWRlIHNlY3VyaXR5IGFuZCBrZXkgc2V0dGluZ3MgdG8gYWxs
b3cgLmRlYnMgdG8gYmUgYnVpbHQNCnNjcmlwdHMvY29uZmlnIC0tZGlzYWJsZSBTWVNURU1fUkVW
T0NBVElPTl9LRVlTIA0Kc2NyaXB0cy9jb25maWcgLS1kaXNhYmxlIERFQlVHX0lORk8gDQpzY3Jp
cHRzL2NvbmZpZyAtLWVuYWJsZSBERUJVR19JTkZPX05PTkUgDQpzY3JpcHRzL2NvbmZpZyAtLXNl
dC1zdHIgU1lTVEVNX1RSVVNURURfS0VZUyAiIiANCm1ha2UgLWokKG5wcm9jKSBkZWItcGtnIExP
Q0FMVkVSU0lPTj0tbGludXhjbmM=
--0000000000001fb1c905fa6c483e--
