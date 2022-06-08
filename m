Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35233C43334
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Jun 2022 09:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiFHJ3t (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Jun 2022 05:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiFHJ30 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Jun 2022 05:29:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8E12B024
        for <linux-rt-users@vger.kernel.org>; Wed,  8 Jun 2022 01:54:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o7so6781452eja.1
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Jun 2022 01:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:dkim-signature:message-id:date
         :mime-version:user-agent:content-language:to:references:from:subject
         :in-reply-to;
        bh=5hK2OZPNmMddWq/BtDBJeA8e8FuO4QRz4WlMJ3Gmoig=;
        b=VVyNtgeDFhl+qws48aQYVoJSdx/tIqDiaS6MeznQrX4cYuOKPLUxldK8unPjJxad60
         jt67iiHYjwUhZOn8W9W6qQurfpcaq5m3dM3Tz53ULlLgLw139XFRF1ZTEjAQqnfTkOCT
         a1RdcRe5IclMA5sSrRAvrqZRZM5+Tean9NLRVAFFJk2P7Pyfh2y5hWpiXodRWd+WSc0k
         WVV08542uqpkU7IEB7IHtlbtDf0SscAOocceAcvQUxejA3zKw0FZbzdjvN8mrs76RRax
         AuDrDUTcCGDifqFUUchjLj2a87Mon3D4GdKS2uqnextmAPngAz/t2NgLvMFLw8p5/Qzr
         1mcw==
X-Gm-Message-State: AOAM531whdw3Fl+4C2vVmrwRYY+JHiCfDDdPS3DkcmtVa2RTfkIZAZeF
        j1tTkoph1+b6TQY8lqqtKoQTibUqWLw=
X-Google-Smtp-Source: ABdhPJxuMW36G6KMKc0nXJPgrU3wge4VSNwEYodFURi95ilw+sqPfGJwaFPMx1636wQSvqJLmpySHA==
X-Received: by 2002:a17:907:7b87:b0:711:d2e6:9e7e with SMTP id ne7-20020a1709077b8700b00711d2e69e7emr12543879ejc.161.1654678488111;
        Wed, 08 Jun 2022 01:54:48 -0700 (PDT)
Received: from smtp.autostatic.com ([185.78.196.210])
        by smtp.gmail.com with ESMTPSA id p21-20020aa7cc95000000b0042fb17da833sm8000100edt.60.2022.06.08.01.54.46
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:54:47 -0700 (PDT)
Sender: Jeremy Jongepier <autostatic@gmail.com>
Received: from [10.250.150.124] (095-097-133-042.static.chello.nl [95.97.133.42])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.autostatic.com (Postfix) with ESMTPSA id 80D1E13B045
        for <linux-rt-users@vger.kernel.org>; Wed,  8 Jun 2022 10:54:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=autostatic.com;
        s=dkim; t=1654678486;
        bh=5hK2OZPNmMddWq/BtDBJeA8e8FuO4QRz4WlMJ3Gmoig=;
        h=Date:To:References:From:Subject:In-Reply-To:From;
        b=PU27Vyankc/JBOh3TUGECZkoGhfvPhNdCNy/nSiJqpA/aruMkO/0t8/LsjUklwWZw
         fudc/Aekv1zPIbj6Sr0hfZemaolVqeTZKnIV42xStG0HT7WR5G3TyxgRRZaaTfz+nF
         3oL3x6tKweWNrUlAAgOGnaPf+na+kV5i7rHZVD3BpHR51uHMZBMu34k9NKwq15Olye
         I/ZoyUyb+uBNKqyOjoLXXIgGrhOtPFWV4kMwoL414YL8q/CgVwcysXanOdaXIGDPRu
         Q66JJNnS0Xpv0u9pWl0I8JyJBd4QLCqwK5NgQelnmAV8Ev86/ef/AMzhPQW2cAhLyR
         RopyX0Z8Zjo/evrlwFxsSud6ucLXOKeR/3eHyTillThamrpzPBW5mo3GJknIB4qxt3
         VwXq5AtEnd8YaLyof5RTKGGsyVkejRK6k8MkOuQ7UIacdF1YEW/clIV05s4UZc5+x/
         Td8YsGcrcyTfuWOnzZVDmd6q9VoK/GYH7wLL9ST1F6VrHQv3bO/8PE/JpM3IxFsJP4
         geG1r3QBf4SRuK+JD1RXwv2B8TfMSvTf3+S00JQqzSRMKq6AffRydNCsoJODk0lYC+
         f3DjBv5WrhVkJ8nij8YkfXx95dJsNN6YlO8AYetXRBcMfzt7iwgvsivV2/iMKVslPL
         +KTxAjHxXxzPmEnTWxZLS65M=
Message-ID: <ef0d74d6-143d-b82d-90f1-5ff6e1336b5a@autostatic.com>
Date:   Wed, 8 Jun 2022 10:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org
References: <CWXP265MB501198E1F104B6044E93E188A5A59@CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM>
 <20220607214725.639e0fc2@archlinux>
From:   Jeremy Jongepier <jeremy@autostatic.com>
Subject: Re: Problems installing a real time kernel.
In-Reply-To: <20220607214725.639e0fc2@archlinux>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------m0D70Dne4hnIlxXIjzPnt660"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------m0D70Dne4hnIlxXIjzPnt660
Content-Type: multipart/mixed; boundary="------------acid3I9GTXoQKcqV6T3ewTyX";
 protected-headers="v1"
From: Jeremy Jongepier <jeremy@autostatic.com>
To: linux-rt-users@vger.kernel.org
Message-ID: <ef0d74d6-143d-b82d-90f1-5ff6e1336b5a@autostatic.com>
Subject: Re: Problems installing a real time kernel.
References: <CWXP265MB501198E1F104B6044E93E188A5A59@CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM>
 <20220607214725.639e0fc2@archlinux>
In-Reply-To: <20220607214725.639e0fc2@archlinux>

--------------acid3I9GTXoQKcqV6T3ewTyX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDctMDYtMjAyMiAyMTo0NywgUmFsZiBNYXJkb3JmIHdyb3RlOg0KPiBJZiB5b3VyIERl
YmlhbiByZWxlYXNlJ3MgcmVwb3Mgc2hvdWxkIHByb3ZpZGUgaXQsIGNvbnNpZGVyIHRvIHRl
c3QNCj4gdXNpbmcgbWFrZS1rcGtnLCBpZiBub3QgY29uc2lkZXIgdG8gYXNrIG9uIGEgRGVi
aWFuIHVzZXIgbWFpbGluZyBsaXN0DQo+IGhvdyB0byBidWlsZCBhIERlYmlhbiBrZXJuZWwg
cGFja2FnZSBub3dhZGF5cy4NCg0KV2l0aCBgbWFrZSBkZWItcGtnYCwgc2VlIA0KaHR0cHM6
Ly9rZXJuZWwtdGVhbS5wYWdlcy5kZWJpYW4ubmV0L2tlcm5lbC1oYW5kYm9vay9jaC1jb21t
b24tdGFza3MuaHRtbCNzLWNvbW1vbi1idWlsZGluZw0KbWFrZS1rcGtnIHdhcyBwYXJ0IG9m
IHRoZSBrZXJuZWwtcGFja2FnZSBwYWNrYWdlIHdoaWNoIGhhcyBiZWVuIHJlbW92ZWQgDQpm
cm9tIERlYmlhbiAyIHllYXJzIGFnbzogDQpodHRwczovL3RyYWNrZXIuZGViaWFuLm9yZy9u
ZXdzLzExNDM3MDEvcmVtb3ZlZC0xMzAxOG5tdTItZnJvbS11bnN0YWJsZS8NCkluIG90aGVy
IHdvcmRzLCBpdCBtaWdodCBiZSBiZXR0ZXIgdG8gcmVmcmFpbiBmcm9tIHRlc3Rpbmcgd2l0
aCANCm1ha2Uta3BrZywgaXQgY29tcGxpY2F0ZXMgdHJvdWJsZXNob290aW5nIGFuZCBpcyBh
biB1bnN1cHBvcnRlZCB3YXkgb2YgDQpidWlsZGluZyBhIGN1c3RvbSBrZXJuZWwgb24gRGVi
aWFuLiBUaGUgYWJvdmUgYWxzbyBhcHBsaWVzIHRvIFVidW50dS4NCg0KQmVzdCwNCg0KSmVy
ZW15DQoNCg==

--------------acid3I9GTXoQKcqV6T3ewTyX--

--------------m0D70Dne4hnIlxXIjzPnt660
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQR5l1irYG7S7ACCPAfiAA0dQfZ2egUCYqBj1QUDAAAAAAAKCRDiAA0dQfZ2emCo
AJ9nJjBo6eYeYAW/MWvac5SHKnP+rwCdFF8j99RHat/0V6wqD2z2meXPfFI=
=wzsj
-----END PGP SIGNATURE-----

--------------m0D70Dne4hnIlxXIjzPnt660--
