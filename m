Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2253AC4332F
	for <linux-rt-users@archiver.kernel.org>; Sat, 10 Dec 2022 01:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiLJBlI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Dec 2022 20:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLJBlH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Dec 2022 20:41:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30BB9D8BB
        for <linux-rt-users@vger.kernel.org>; Fri,  9 Dec 2022 17:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670636414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=crD2TSHJPEOXGsbaYVla2gOMkl4nyt+X99CfQbEv4cI=;
        b=YKB4qQ0hrxMCwLYyRKn7Ipc2eS2uAZvbD2ifmQPene+1eb5UARSdOGmGe/gt8rsITCMaCj
        M1bfoEhaBEes1NlY4+1qv1bESqZCOSk60vaRQ37MwB/yz79Yk8tXNSfoa7zzNRJFWakBIh
        Cn0LP2eRemrVSGMQBklVmsxpAYmpUEo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-YyaG9L_WPfmvvbn1cFOp8Q-1; Fri, 09 Dec 2022 20:40:12 -0500
X-MC-Unique: YyaG9L_WPfmvvbn1cFOp8Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C2A83C0D84B
        for <linux-rt-users@vger.kernel.org>; Sat, 10 Dec 2022 01:40:12 +0000 (UTC)
Received: from [10.22.34.151] (unknown [10.22.34.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09A74477F5C;
        Sat, 10 Dec 2022 01:40:11 +0000 (UTC)
Message-ID: <e1402a544c74b508b6d2b4cc644fce5909ccd863.camel@redhat.com>
Subject: Re: [PATCH] oslat: Add command line option for bucket width
From:   Crystal Wood <swood@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
Date:   Fri, 09 Dec 2022 19:40:09 -0600
In-Reply-To: <1624dd34-d12c-38dc-aed1-a34366ceafba@redhat.com>
References: <20221209052254.2609767-1-swood@redhat.com>
         <1624dd34-d12c-38dc-aed1-a34366ceafba@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTA5IGF0IDIwOjAzIC0wNTAwLCBKb2huIEthY3VyIHdyb3RlOgo+IAo+
IAo+IE9uIFRodSwgOCBEZWMgMjAyMiwgQ3J5c3RhbCBXb29kIHdyb3RlOgo+IAo+IAo+ID4gwqAK
PiA+IEBAIC02NzcsNiArNjk5LDIwIEBAIHN0YXRpYyB2b2lkIHBhcnNlX29wdGlvbnMoaW50IGFy
Z2MsIGNoYXIgKmFyZ3ZbXSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBleGl0KDEpOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY2FzZSBPUFRfQlVDS0VUV0lEVEg6Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY2FzZSAnVyc6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGcuYnVja2V0X3dpZHRoID0gc3RydG9sKG9wdGFyZywgTlVMTCwg
MTApOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAoZy5idWNrZXRfc2l6ZSA8PSAwKSB7Cj4gCj4gSSB0aGluayB0aGlzIHNob3VsZCBiZSBnLmJ1
Y2tldF93aWR0aAoKT29wcwoKPiAKPiBBIHF1aWNrIGZpcnN0IGxvb2sgdGhyb3VnaCBhbmQgcnVu
LCBzZWUgdGhlIG9uZSBjb21tZW50IGFib3ZlCj4gbmVhciAiY2FzZSAnVyciCj4gCj4gYW5kIHRo
ZW4KPiAKPiBjaGVja3BhdGNoIHJlcG9ydHMgc29tZSBtaW5vciBlYXNpbHkgZml4ZWQgcHJvYmxl
bXMKPiAKPiAuLi9saW51eC9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgb3NsYXQucGF0Y2ggCj4gRVJS
T1I6IGNvZGUgaW5kZW50IHNob3VsZCB1c2UgdGFicyB3aGVyZSBwb3NzaWJsZQo+ICMxMDA6IEZJ
TEU6IHNyYy9vc2xhdC9vc2xhdC5jOjM0MjoKPiArXkleScKgwqDCoMKgwqDCoMKgwqDCoCBnLnBy
ZWNpc2lvbiwgdXMpOyQKPiAKPiBFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIHVzZSB0YWJzIHdo
ZXJlIHBvc3NpYmxlCj4gIzEwMjogRklMRTogc3JjL29zbGF0L29zbGF0LmM6MzQ0Ogo+ICteSV5J
wqDCoMKgwqDCoMKgwqDCoCBnLnByZWNpc2lvbiwgdXMpOyQKCkkgd2FzIG1hdGNoaW5nIHRoZSBl
eGlzdGluZyBzdHlsZSBpbiB0aGUgZmlsZSB0aGF0IHRlbmRlZCB0byB1c2Ugc3BhY2VzIGZvcgph
bGlnbm1lbnQuCgo+IEVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJz0nIChjdHg6
VnhWKQo+ICMyMjc6IEZJTEU6IHNyYy9vc2xhdC9vc2xhdC5jOjY1NDoKPiArwqDCoMKgwqDCoMKg
wqBPUFRfQlVDS0VUU0laRT0xLCBPUFRfQlVDS0VUV0lEVEgsIE9QVF9DUFVfTElTVCwgCj4gT1BU
X0NQVV9NQUlOX1RIUkVBRCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgXgoKSSBvbmx5IGFkZGVkIE9QVF9CVUNLRVRXSURUSCB0byB0aGUgbGlzdDsgSSBkaWRu
J3QgdG91Y2ggdGhlID0xIHBhcnQuCgotU2NvdHQKCg==

