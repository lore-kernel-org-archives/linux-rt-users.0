Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793167967;
	b=nbcso/49s2P199rfA0J0uOqprjhnK1gMsIs/5XjUVuqMWpjMuzflMJ7crKSkzhnehoV8
	 8Muzk0RBzMCtd9VB4FJGdq56ZfQlmK0wXy6ic/O5JXk4dWqC3HLrbftJpMwZyU3gIrC/F
	 2d5ql/8p3D8+WZ0qGNKhdt52qN+NU8R/iqqbF0+SjA3QuFA104dcHy7zM3CrEsjZKrmmI
	 RqhHZrIF9H6viqe+uwyuo4sDYB91y93LfR6L5vNtoHgluJ+sKEcFDVFSt1iz6hWW9j1pa
	 B01vZrkHJsN2tAd1i7aKP+ukCsL4hF9e25pLCgwQEg16WefNpRgAeINmNMOHwP6AIBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/vH8svNzpZR3ULISFPWmyW8LKaDY4C12Ynn5Rm/msKo=;
	b=ryy1GUzliCDUuO4j85TaHesJV5dbZjAL0DhPJAc8lxpG/ygBocos5Te3z0QbrDtabJ7e
	 tAByTeHe0CEoxkVFgMbi7EUmqEsVFEPvWJyjGJzRylFcsWT07zFNoF4zO1BDplrimF+Rp
	 N0azJvKXq3a9zu46iKSVtgc6ynG2FwplbNC4qpD47r12+zwe+xx2pdaYSjQRg6BcW2yXw
	 LgK7awFdjkgSwqa+BmGRmtg6XAxHNvgln4jE8Ja8LmyIL5Sqqxr6FSyd/xir1SRqnJRSk
	 E1PWtAvIyIMkYIKxQH85LHe7Ns0FNBwTAxskULYRGQw2SIWzOgaXXBts1HsULk5Q1Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VfrykiKs;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31167606A31A
	for <linux-rt-users@vger.kernel.org>; Wed, 28 Oct 2026 06:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31167606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VfrykiKs
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35c76e9614aso945568eec.0
        for <linux-rt-users@vger.kernel.org>; Tue, 27 Oct 2026 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793167966; x=1793772766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/vH8svNzpZR3ULISFPWmyW8LKaDY4C12Ynn5Rm/msKo=;
        b=VfrykiKsLvUeI4AU6lFRa79CRlt+gZVHKmNMefWfx+TtHj93aY2Xhw+tnH48u/gmm/
         w51RqaNSAEWk6KLV2ZrR7kkJZTzq0LeSRIA7MHlv+86+CD5K9XniePaD6Bd02SWtZC+D
         G3rnZPQ43LMB6TiR2gX0QnvNCCcJWHPyStyGAc6X4Khy3psNJKyLKZJxLahkQ5BRLc1W
         ZA2tDAv81MkanWyYK+SRCuFadP7vLA+wZ64as35dUu6hl1elbwPadRVATQP2Jj63OcLh
         05HHjBUx6DShPKjFo/g2aG+qSztbOP0K0gS0jQ9Od7Gmw0Zy3a9GwLXjSEqIEHLLn3n0
         bnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793167966; x=1793772766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/vH8svNzpZR3ULISFPWmyW8LKaDY4C12Ynn5Rm/msKo=;
        b=EaU+WIsCpc+Vi2ZLLDMxbSrIdo0XVrAW9njbA5xZThiP4gTJeWIXv5ydN/ldbnshP6
         pyFvZx8TMP09Wyq2xPGfTZxZWl6jkgtzbXkgh4A6DMkuvrZx1rYxULbxnGQv0m9jspPz
         y+MSBIe4zmfsFNcmc0/HFss3Asfn8PT26AZPLZ8XGtN+wQ1r5irwmLUZWGY6YYtziP+R
         hB2Rw3bDBL5U42/q39vtoEXFZJ3WvYV+Z7fEJRgSnBncC7GVJ3P4ziHOCs6adsCHmisN
         RFiOLJJzVuuiLafsGH7CfqS7R/XABEjDNGH9TyYeQMDJZefPZjkhpV5JnvkIq1HYlQLI
         jFOQ==
X-Gm-Message-State: AFq9FYLJHRs0LTkKk38+BNU7yT3DuWbliVOt4K03t+8bIntKQUliMQWQ
	OB5nPHEATgXR5lMCR5GqZAvFsQYqu58DlHzfK6e3/tYt6AlwGkDLSMSr
X-Gm-Gg: AYBFou3uzlvBQSGvL1T8dSO+vo3fzwgWyUHqqFK3XKue3qExIUI4/Sf75WCRPGvPxJr
	b/oefg8zXR7JBNTZTQqxMVK/Gu4F6JGPNsBlI1w822ja0OZ+EIDU7x+U21m9cFWZrE9lc0cPVRI
	JwIsnhmJb+nzot30tqgp7g1bX6eA8LuJbhNqHDSvomMEhg3T6WgPNzEZUAxVCNI01CCcNJ5FfcW
	0JCkJH3w7TkP3gTMieLRP2pdkbzekOCQhg6BFT1JknZf3MxH1+x025K++tPSyohFXKy32W+qD9E
	lRtO/815E+ErsUW1GTGnsjUVokDcH/7q1XNv3XfaBRViV73ZMcAaag2PbZdOpxqGqhLqTb6oomF
	9D6Eosq+BVnq0VUQscR+N9WgjlU9ZpJ45HhHjwT3rY3JoiZs3kYB5ubX5uxo41b9yLQeqW8oCHN
	HdfGrzrcA2wFHctA40XXypysKpjONveYN6UdqP3qa9d16vLVbp8Q8t8f8aZEsxWkWaOhsFqULik
	vq90oWPUeUz6m9yJ/1m6z/j4XgELQIrPomfuhp2q2vgaSt1u5czL36MRt3O7BIKXQv2loze6q+U
	lhUQoHIK5zzTEWByTAKxDb49eP99fY6qDQ+fvFPeJPISge0uOVKtitg4CNjKqRUflKGrNiGohsv
	6PUFKhM7TCXGXwVxu1zAhHl/HTLKq4us6nHl7kJm/rSj8fWmcb3seJAmyGbDcfIasodv4yApXwC
	scP6lhwFBZkhbwG5w6Gpuj7BdAvtczYi2SL2NTMydKKgMchjOw6BU8R1Bbt4qcStnYvlVOok5on
	ycCQW0Cf+WuA62U4VOr1Om7H6ZoU+WLP3JsWBmqwQZR4v8hOUsBgLQraOyDkqlS58iWnQQ=
X-Received: by 2002:a05:693c:2506:b0:36a:214f:169e with SMTP id 5a478bee46e88-36a214f260cmr1584641eec.21.1793167966121;
        Tue, 27 Oct 2026 23:12:46 -0700 (PDT)
Received: from apollo.tail3ccdd3.ts.net ([147.160.63.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2390a812sm3050430eec.14.2026.10.27.23.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 23:12:45 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] tuna: Do not import tuna from setup.py
Date: Tue, 27 Oct 2026 23:12:43 -0700
Message-ID: <20261028061243.4061773-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cb5593a2be9c ("tuna: Get the tuna version from a single source")
made setup.py import tuna.version. setup.py runs from the setuptools
build backend, which does not put the source directory on sys.path (only
the legacy backend does), so building with a PEP 517 frontend fails:

  $ python3 -m build --no-isolation --wheel
  ...
    File "<string>", line 9, in <module>
  ModuleNotFoundError: No module named 'tuna'
  ERROR Backend subprocess exited when trying to invoke get_requires_for_build_wheel

pyproject.toml already takes the version from tuna.version.TUNA_VERSION
via [tool.setuptools.dynamic], which setuptools reads without importing
the package, so drop the import and the version argument from setup().

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 setup.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/setup.py b/setup.py
index 8036a64..07ec523 100755
--- a/setup.py
+++ b/setup.py
@@ -5,9 +5,6 @@ import sysconfig
 from os.path import isfile, relpath
 from setuptools import setup
 
-# Get the tuna version from a single source
-from tuna.version import TUNA_VERSION
-
 if isfile("MANIFEST"):
     os.unlink("MANIFEST")
 
@@ -19,7 +16,6 @@ if SCHEME not in sysconfig.get_scheme_names():
 PYTHONLIB = relpath(sysconfig.get_path('platlib', SCHEME), '/usr')
 
 setup(name="tuna",
-      version = TUNA_VERSION,
       description = "Application tuning GUI",
       author = "Arnaldo Carvalho de Melo, John Kacur",
       author_email = "acme@redhat.com, jkacur@redhat.com",
