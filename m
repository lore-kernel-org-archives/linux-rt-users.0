Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248DE55E73
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Mar 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240202; cv=none; b=oIavj2aTH3EFfOnp41bJ9//flh1lDxYKjEPsjpo5L6haxHg65aUKVjgs1K6mARBVHTro2A28R01Bo+GExIId4IyQkOhvwxEMhTf1NlmYwEj6Piwt0f/7R9/ECxiVsKrSyV/vXpED5BYASxJ43upHmkGNZ5nxQSQhjooeaiTOt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240202; c=relaxed/simple;
	bh=hiLT2ZUrONEamB1dX1ThWJH/SswfAAPXq30CYs4DURk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5yE69e52Jaqahvus43CAMp/d9qGKd/jbeQKBJ/162RDkyadcYaKc8mv9+sl8IRAnK7918MS48Q9Tophlasye1cry7W4ZbsNc6V6xUQa5WmiQ9RmfDTLnq44GR6pVDK1VqH5BZIUv2BMjS2V+DZoqDozD12hrAo8TAgq7F0TygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UQPbaH/j; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UQPbaH/j"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dd9bf7fb6cso131785ad.0
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Mar 2024 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710240200; x=1710845000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yk2wZMh+Y2QPMM44iJgNmHipyb1cEpvqk53zIuwkD4U=;
        b=UQPbaH/jzww5A9nrrWRDlHONkIi0I9ttiKNVGOsluJCl8j24pAykkGSVO5+eNtlm5s
         ZtjmtJWnRlUeeGnZppjkDLnRhCkab/R1p/t3VOvHD4KUabiXPlw4mss9f0lFzWG8+lLx
         nYIM4ePvWUGKcBP6AI2Ye/V/aSB2qYVXIozx4Llvtsg+LdG1NP6m/+6wu2FXQUfeEy9Z
         GciDZvIJEPq0iNyw84g12gX/1S7xLAAr+qdPS09lMukwrScZfRTSgOAB9fD1mGTaeap/
         Exq39q9QVUJHxXYOQ84movlWpUeklbiKq+yQA+OrX0MnZ8CCiavxZmMGT636I/jUfuy6
         eEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710240200; x=1710845000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yk2wZMh+Y2QPMM44iJgNmHipyb1cEpvqk53zIuwkD4U=;
        b=ttQJNBajMMLKnyTKatkuoylL2/XE3RgsCPH2++4mDg+CwmjNU4vBhW6Kinm1fYkfaa
         wfabOLL/ELHEH+T2nhqpBf+4igJSPxrUy29UzaJIin8QWrCI+5JlYhdOy58XwCaWdNjm
         krKuN6zGU9XE7TKgjPI0V9cf3j8wHDCptfX7iny30hwPKuewejZXhWxoky1HOUIijPnH
         LajWHkv8WQHzZNeUr8Nm8oLBMFqDjcoXGhL7FG7nUW04wITjRbOXhxvSqtG8VmDIdnjd
         qkawb6s9gjnTabiFL9Aty9ZfgtBk4WKlSQvxcGEeF5yc9ILD8Tm3Y2geXOkmMTRJPEnL
         ltQA==
X-Gm-Message-State: AOJu0YwZiViPQW+5XAaxLtOUAKQpDcwS6qmM/8jCLnQ+mtT+UY2UdjWs
	weLeqAyNPTtnsZlBW0JOSvBJgU8/hJC4BbQPX/rLeQMool+/iBkknoDQEOf/j5hKEQRjdxhQd/5
	f8gMW9u3WnYBJOGKA0aD/AtojBEYQkbBQxZ/Jyok0p8v7IbzakQ==
X-Google-Smtp-Source: AGHT+IFfYwtO18Ykei6gFbqLx3jx2iFBDgk5kM9W82YPx+WpxSzyW8sFCjcV6vmGwwUMd+ZmxHGGCg2QTN5Tdc1Ehos=
X-Received: by 2002:a17:902:e5c2:b0:1db:a356:b954 with SMTP id
 u2-20020a170902e5c200b001dba356b954mr179801plf.28.1710240200061; Tue, 12 Mar
 2024 03:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMnS4ZDigjkexNdJT3ZhLcmAMeodTKsPi+b91sSjE5sky7ZfqQ@mail.gmail.com>
 <7f10669d-fffa-40f1-86e2-db3033957b19@redhat.com>
In-Reply-To: <7f10669d-fffa-40f1-86e2-db3033957b19@redhat.com>
From: Rodrigo Queiro <rodrigoq@google.com>
Date: Tue, 12 Mar 2024 11:43:06 +0100
Message-ID: <CAMnS4ZALUHVuH7YAGNA1+A8n7Tc+pLpso0Ywr4Z39UcC4g6e5w@mail.gmail.com>
Subject: Re: Alternative to updating has_smi_counter?
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009c3de20613745300"

--0000000000009c3de20613745300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks! Are you aware of a complete beginners guide on how to send
changes for review? I'm afraid I've only used the GitHub or
company-internal workflows, so I'm not sure how to submit the attached
change.


On Mon, Feb 19, 2024 at 2:21=E2=80=AFPM Daniel Bristot de Oliveira
<bristot@redhat.com> wrote:
>
> On 2/19/24 12:36, Rodrigo Queiro wrote:
> > What do you think about removing the checks on the model number, and
> > assuming that all processors with family =3D=3D 6 support the Nehalem
> > MSRs, including the SMI counter? Any user running a recent cyclictest
> > on pre-Nehalem hardware could still run without --smi to prevent
> > seeing bogus SMI counts.
>
> When I added that option the smi was a relatively new thing... nowadays I=
 think
> it is pretty standard... so simplifying it is a good thing.
>
> Nevertheless, the SMI counter is just part of the story. Most
> of the hardware related latency problems goes outside of SMI "domain"
> so... the best thing to do is to run rtla hwnoise (or hwlat) on
> the hardware to detect hardware latencies.
>
> -- Daniel
>

--0000000000009c3de20613745300
Content-Type: application/octet-stream; 
	name="0001-Support-smi-on-newer-processors.patch"
Content-Disposition: attachment; 
	filename="0001-Support-smi-on-newer-processors.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lto8tzzw0>
X-Attachment-Id: f_lto8tzzw0

RnJvbSBiOTFiYjM5N2ViNjZhNWYxNmQ5MDE5MDk0ZmUwNWQyMWM2YzQ1MTJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2RyaWdvIFF1ZWlybyA8cm9kcmlnb3FAZ29vZ2xlLmNvbT4K
RGF0ZTogTW9uLCAxOSBGZWIgMjAyNCAxNDo1MzowNSArMDAwMApTdWJqZWN0OiBbUEFUQ0hdIFN1
cHBvcnQgLS1zbWkgb24gbmV3ZXIgcHJvY2Vzc29ycwoKVGhpcyBhdm9pZHMgdGhlIG5lZWQgdG8g
dXBkYXRlIGN5Y2xpY3Rlc3QuYyBmb3IgZXZlcnkgbmV3IENQVSBmYW1pbHksIGF0CnRoZSBjb3N0
IG9mIGdlbmVyYXRpbmcgYm9ndXMgU01JIG51bWJlcnMgb24gcHJlLTIwMDggQ1BVcy4gQmFzZWQg
b24gdGhlCmNvbW1lbnQgZnJvbSBEYW5pZWwgQnJpc3RvdCBkZSBPbGl2aWVyYToKCj4gV2hlbiBJ
IGFkZGVkIHRoYXQgb3B0aW9uIHRoZSBzbWkgd2FzIGEgcmVsYXRpdmVseSBuZXcgdGhpbmcuLi4K
PiBub3dhZGF5cyBJIHRoaW5rIGl0IGlzIHByZXR0eSBzdGFuZGFyZC4uLgo+IHNvIHNpbXBsaWZ5
aW5nIGl0IGlzIGEgZ29vZCB0aGluZy4KLS0tCiBzcmMvY3ljbGljdGVzdC9jeWNsaWN0ZXN0LmMg
fCA5MSArKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA4MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvY3lj
bGljdGVzdC9jeWNsaWN0ZXN0LmMgYi9zcmMvY3ljbGljdGVzdC9jeWNsaWN0ZXN0LmMKaW5kZXgg
MzNmYWMzYi4uOGE5NjMzOSAxMDA2NDQKLS0tIGEvc3JjL2N5Y2xpY3Rlc3QvY3ljbGljdGVzdC5j
CisrKyBiL3NyYy9jeWNsaWN0ZXN0L2N5Y2xpY3Rlc3QuYwpAQCAtNDA0LDcgKzQwNCwxNCBAQCBz
dGF0aWMgaW50IGdldF9zbWlfY291bnRlcihpbnQgZmQsIHVuc2lnbmVkIGxvbmcgKmNvdW50ZXIp
CiAKICNpbmNsdWRlIDxjcHVpZC5oPgogCi0vKiBCYXNlZCBvbiB0dXJib3N0YXQncyBjaGVjayAq
LworLyogR3Vlc3MgaWYgdGhlIENQVSBoYXMgYW4gU01JIGNvdW50ZXIgaW4gdGhlIG1vZGVsLXNw
ZWNpZmljIHJlZ2lzdGVycyAoTVNSKS4KKyAqCisgKiBUaGlzIGlzIHRydWUgZm9yIEludGVsIHg4
NiBDUFVzIGFmdGVyIE5laGFsZW0gKDIwMDgpLiBIb3dldmVyLCBpdCdzIG5vdAorICogcG9zc2li
bGUgdG8gZGV0ZWN0IHRoZSBmZWF0dXJlIGRpcmVjdGx5LCAob3IgYXQgbGVhc3QsIHR1cmJvc3Rh
dC5jIGRvZXNuJ3QKKyAqIGtub3cgaG93IHRvIGRvIGl0IGVpdGhlcikgc28gd2UgYXNzdW1lIGl0
J3MgdHJ1ZSBmb3IgYWxsIHg4NiBDUFVzLgorICogUHJldmlvdXNseSwgdGhpcyBmdW5jdGlvbiBo
YWQgYW4gZXhwbGljaXQgYWxsb3dsaXN0LCB3aGljaCByZXF1aXJlZCB1cGRhdGVzCisgKiBldmVy
eSB0aW1lIGEgbmV3IENQVSBnZW5lcmF0aW9uIHdhcyByZWxlYXNlZC4KKyAqLwogc3RhdGljIGlu
dCBoYXNfc21pX2NvdW50ZXIodm9pZCkKIHsKIAl1bnNpZ25lZCBpbnQgZWJ4LCBlY3gsIGVkeCwg
bWF4X2xldmVsOwpAQCAtNDI4LDg4ICs0MzUsNiBAQCBzdGF0aWMgaW50IGhhc19zbWlfY291bnRl
cih2b2lkKQogCWlmICghKGVkeCAmICgxIDw8IDUpKSkKIAkJcmV0dXJuIDA7CiAKLQltb2RlbCA9
ICgoKGZtcyA+PiAxNikgJiAweGYpIDw8IDQpICsgKChmbXMgPj4gNCkgJiAweGYpOwotCi0JLyog
QmFzZWQgb24gaW50ZWxfbW9kZWxfZHVwbGljYXRlcyAqLwotCXN3aXRjaCAobW9kZWwpIHsKLQlj
YXNlIDB4MUE6ICAgICAgLyogSU5URUxfRkFNNl9ORUhBTEVNX0VQICovCi0JY2FzZSAweDFFOiAg
ICAgIC8qIElOVEVMX0ZBTTZfTkVIQUxFTSAqLwotCWNhc2UgMHgxRjogICAgICAvKiBDb3JlIGk3
IGFuZCBpNSBQcm9jZXNzb3IgLSBOZWhhbGVtICovCi0JY2FzZSAweDI1OiAgICAgIC8qIElOVEVM
X0ZBTTZfV0VTVE1FUkUgKi8KLQljYXNlIDB4MkM6ICAgICAgLyogSU5URUxfRkFNNl9XRVNUTUVS
RV9FUCAqLwotCQltb2RlbCA9IDB4MUU7ICAgICAgLyogSU5URUxfRkFNNl9ORUhBTEVNICovCi0J
CWJyZWFrOwotCWNhc2UgMHgyRTogICAgICAvKiBJTlRFTF9GQU02X05FSEFMRU1fRVggKi8KLQlj
YXNlIDB4MkY6ICAgICAgLyogSU5URUxfRkFNNl9XRVNUTUVSRV9FWCAqLwotCQltb2RlbCA9IDB4
MkU7ICAgICAgLyogSU5URUxfRkFNNl9ORUhBTEVNX0VYICovCi0JCWJyZWFrOwotCWNhc2UgMHg4
NTogICAgICAvKiBJTlRFTF9GQU02X1hFT05fUEhJX0tOTSAqLwotCQltb2RlbCA9IDB4NTc7ICAg
ICAgLyogSU5URUxfRkFNNl9YRU9OX1BISV9LTkwgKi8KLQkJYnJlYWs7Ci0JY2FzZSAweDRGOiAg
ICAgIC8qIElOVEVMX0ZBTTZfQlJPQURXRUxMX1ggKi8KLQljYXNlIDB4NTY6ICAgICAgLyogSU5U
RUxfRkFNNl9CUk9BRFdFTExfRCAqLwotCQltb2RlbCA9IDB4NEY7ICAgICAgLyogSU5URUxfRkFN
Nl9CUk9BRFdFTExfWCAqLwotCQlicmVhazsKLQljYXNlIDB4NEU6ICAgICAgLyogSU5URUxfRkFN
Nl9TS1lMQUtFX0wgKi8KLQljYXNlIDB4NUU6ICAgICAgLyogSU5URUxfRkFNNl9TS1lMQUtFICov
Ci0JY2FzZSAweDhFOiAgICAgIC8qIElOVEVMX0ZBTTZfS0FCWUxBS0VfTCAqLwotCWNhc2UgMHg5
RTogICAgICAvKiBJTlRFTF9GQU02X0tBQllMQUtFICovCi0JY2FzZSAweEE2OiAgICAgIC8qIElO
VEVMX0ZBTTZfQ09NRVRMQUtFX0wgKi8KLQljYXNlIDB4QTU6ICAgICAgLyogSU5URUxfRkFNNl9D
T01FVExBS0UgKi8KLQkJbW9kZWwgPSAweDRFOyAgICAgIC8qIElOVEVMX0ZBTTZfU0tZTEFLRV9M
ICovCi0JCWJyZWFrOwotCWNhc2UgMHg3RTogICAgICAvKiBJTlRFTF9GQU02X0lDRUxBS0VfTCAq
LwotCWNhc2UgMHg5RDogICAgICAvKiBJTlRFTF9GQU02X0lDRUxBS0VfTk5QSSAqLwotCWNhc2Ug
MHg4QzogICAgICAvKiBJTlRFTF9GQU02X1RJR0VSTEFLRV9MICovCi0JY2FzZSAweDhEOiAgICAg
IC8qIElOVEVMX0ZBTTZfVElHRVJMQUtFICovCi0JY2FzZSAweEE3OiAgICAgIC8qIElOVEVMX0ZB
TTZfUk9DS0VUTEFLRSAqLwotCWNhc2UgMHg4QTogICAgICAvKiBJTlRFTF9GQU02X0xBS0VGSUVM
RCAqLwotCWNhc2UgMHg5NzogICAgICAvKiBJTlRFTF9GQU02X0FMREVSTEFLRSAqLwotCWNhc2Ug
MHg5QTogICAgICAvKiBJTlRFTF9GQU02X0FMREVSTEFLRV9MICovCi0JCW1vZGVsID0gMHg2Njsg
ICAgICAvKiBJTlRFTF9GQU02X0NBTk5PTkxBS0VfTCAqLwotCQlicmVhazsKLQljYXNlIDB4OUM6
ICAgICAgLyogSU5URUxfRkFNNl9BVE9NX1RSRU1PTlRfTCAqLwotCQltb2RlbCA9IDB4OTY7ICAg
ICAgLyogSU5URUxfRkFNNl9BVE9NX1RSRU1PTlQgKi8KLQkJYnJlYWs7Ci0JY2FzZSAweDZDOiAg
ICAgIC8qIElOVEVMX0ZBTTZfSUNFTEFLRV9EICovCi0JY2FzZSAweDhGOiAgICAgIC8qIElOVEVM
X0ZBTTZfU0FQUEhJUkVSQVBJRFNfWCAqLwotCQltb2RlbCA9IDB4NkE7ICAgICAgLyogSU5URUxf
RkFNNl9JQ0VMQUtFX1ggKi8KLQkJYnJlYWs7Ci0JfQotCi0JLyogQmFzZWQgb24gcHJvYmVfbmht
X21zcnMgKi8KLQlzd2l0Y2ggKG1vZGVsKSB7Ci0JY2FzZSAweDFFOiAgICAgIC8qIElOVEVMX0ZB
TTZfTkVIQUxFTSAqLwotCWNhc2UgMHgyRTogICAgICAvKiBJTlRFTF9GQU02X05FSEFMRU1fRVgg
Ki8KLQljYXNlIDB4MkE6ICAgICAgLyogSU5URUxfRkFNNl9TQU5EWUJSSURHRSAqLwotCWNhc2Ug
MHgyRDogICAgICAvKiBJTlRFTF9GQU02X1NBTkRZQlJJREdFX1ggKi8KLQljYXNlIDB4M0E6ICAg
ICAgLyogSU5URUxfRkFNNl9JVllCUklER0UgKi8KLQljYXNlIDB4M0U6ICAgICAgLyogSU5URUxf
RkFNNl9JVllCUklER0VfWCAqLwotCWNhc2UgMHgzQzogICAgICAvKiBJTlRFTF9GQU02X0hBU1dF
TEwgKi8KLQljYXNlIDB4NDY6ICAgICAgLyogSU5URUxfRkFNNl9IQVNXRUxMX0cgKi8KLQljYXNl
IDB4M0Y6ICAgICAgLyogSU5URUxfRkFNNl9IQVNXRUxMX1ggKi8KLQljYXNlIDB4NDU6ICAgICAg
LyogSU5URUxfRkFNNl9IQVNXRUxMX0wgKi8KLQljYXNlIDB4M0Q6ICAgICAgLyogSU5URUxfRkFN
Nl9CUk9BRFdFTEwgKi8KLQljYXNlIDB4NDc6ICAgICAgLyogSU5URUxfRkFNNl9CUk9BRFdFTExf
RyAqLwotCWNhc2UgMHg0RjogICAgICAvKiBJTlRFTF9GQU02X0JST0FEV0VMTF9YICovCi0JY2Fz
ZSAweDRFOiAgICAgIC8qIElOVEVMX0ZBTTZfU0tZTEFLRV9MICovCi0JY2FzZSAweDY2OiAgICAg
IC8qIElOVEVMX0ZBTTZfQ0FOTk9OTEFLRV9MICovCi0JY2FzZSAweDU1OiAgICAgIC8qIElOVEVM
X0ZBTTZfU0tZTEFLRV9YICovCi0JY2FzZSAweDZBOiAgICAgIC8qIElOVEVMX0ZBTTZfSUNFTEFL
RV9YICovCi0JY2FzZSAweDM3OiAgICAgIC8qIElOVEVMX0ZBTTZfQVRPTV9TSUxWRVJNT05UICov
Ci0JY2FzZSAweDREOiAgICAgIC8qIElOVEVMX0ZBTTZfQVRPTV9TSUxWRVJNT05UX0QgKi8KLQlj
YXNlIDB4NEM6ICAgICAgLyogSU5URUxfRkFNNl9BVE9NX0FJUk1PTlQgKi8KLQljYXNlIDB4NTc6
ICAgICAgLyogSU5URUxfRkFNNl9YRU9OX1BISV9LTkwgKi8KLQljYXNlIDB4NUM6ICAgICAgLyog
SU5URUxfRkFNNl9BVE9NX0dPTERNT05UICovCi0JY2FzZSAweDdBOiAgICAgIC8qIElOVEVMX0ZB
TTZfQVRPTV9HT0xETU9OVF9QTFVTICovCi0JY2FzZSAweDVGOiAgICAgIC8qIElOVEVMX0ZBTTZf
QVRPTV9HT0xETU9OVF9EICovCi0JY2FzZSAweDk2OiAgICAgIC8qIElOVEVMX0ZBTTZfQVRPTV9U
UkVNT05UICovCi0JY2FzZSAweDg2OiAgICAgIC8qIElOVEVMX0ZBTTZfQVRPTV9UUkVNT05UX0Qg
Ki8KLQkJYnJlYWs7Ci0JZGVmYXVsdDoKLQkJcmV0dXJuIDA7Ci0JfQotCiAJcmV0dXJuIDE7CiB9
CiAjZWxzZQotLSAKMi40NC4wLnJjMC4yNTguZzczMjBlOTU4ODYtZ29vZwoK
--0000000000009c3de20613745300--
