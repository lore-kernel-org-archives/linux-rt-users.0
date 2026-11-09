Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259439;
	b=hUhPnrPPLLpsqY57qLSOkgfTSXdYPjkCSo/d2GhS5CQq5A/XHCsnQQP5Jv4rgcniJ5y7
	 4tCIoiK6s+yeP0G/edOHaoAh8fZ/d6x2tcAiSmndxBVfjA6rEg+TdyV3wnDX0o6JIu9XD
	 D/82ulCWL5Z+mR4YJTvI5wE+KcQPPJb3xI8dNgXP9Y7qYnMOCjxY4+ABMIZQnoIwjEa+M
	 jpyJpPejPFJxIxR/86VYdMCAVO/eBntkH/04QSU1kBksYwDHlZhfHKxPagkyd9ErgI/Jg
	 dKbPmDYVDCCR6qIpoQgtwWvGUQoFSm6u5AKh9QriQPt/9unNN+y+c7qFssRjObj/fZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=twI4GrTKIw6M/tjJlQZdbys0xNVMJzvnklabRPZ2m44=;
	b=rp0I0Egu4PFu16nGe8c8Upc54upk1ggc0wlfvsXkwVCNQES+vfFMu7x2A+sHjye5FtHQ
	 B70lG++zkIYRuppfdMk2rjj4j+r/jBxzWbxoNzPXTVqUQrt5C5fGoB9UqXi9IEmEYbdpT
	 +ZNseK/i1u/XijZg0+W3d3UPHlpQcG7aA0l9WHQ7ZAA1SZf5g7xbtEFwVU3lINA2f7ZOp
	 NxAaYVgJyR/mzMzbuMYh4YL0qxFb3sqBc5sQRmqXQS70xO6YhFu7JKFTo9J9wp61eg6OW
	 oeaSEAl0n1JRlHDwc4BVuGhtTM3slBYbWSG2m1qhRS2Qcs3s14kmCtHwJz1fzcapsbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4HR8fei;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B3B606A31C
	for <linux-rt-users@vger.kernel.org>; Mon,  9 Nov 2026 21:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B3B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4HR8fei
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53e1d40628eso16610721cf.0
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Nov 2026 13:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794259438; x=1794864238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=twI4GrTKIw6M/tjJlQZdbys0xNVMJzvnklabRPZ2m44=;
        b=p4HR8fei7q49/n6bKTUxjd8F89RiP41Mwnx7buhGzso2c9kLObT8FwzfhqT57tptJY
         La+HAGyiBJapkwrg93AO77ySjv8LK13IRvw+mnS+Gk236HlqxboTxwYMUWh3tyiK6rIa
         L815HPo7M3GMVrE1hBaaXaQOAyJjAG7K8LmV/HLgK6HeSTmMyHLj0tCRisqzdGJKT6HF
         BIVt7EvOiXpWkZMwXFMdPU1QPtXGfjQlRmdnyWQKJJ2kn0/vHLGdyP9N7qvXLdKHVvEG
         CKTNfO6Z6AOZtvS5ogaFV6Y28s2UD4G5k3d9/pzUFUInepWnQPDDGKwK1UkRSW8hi5jT
         QStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259438; x=1794864238;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twI4GrTKIw6M/tjJlQZdbys0xNVMJzvnklabRPZ2m44=;
        b=JkgVtJrkBxJJEljRlALEZPL0VVXOZ/Lps0E6W3RtCX06yqSeU7Qz8qEEJgqc7GQjB8
         kR3Kkm+KUZv0KAsWf9g2MOL71y1TM4+L4fA/X7Ms703nnGjgtFeqQM5Lpu0L8f4vy3Kn
         9iFYYhZ2CL+e9Wl6qPaepmhxs9UpDG5kyoWjp6LdnDOffOS99++IhdjUZBuRioQz4F/p
         gKxBXLghukr5s8kBi7azdGIX9g875uNQG2KDdOe0ZRc9WoHdKEJZoSNNE3Zd3kCnugu2
         Za/7sAJJG9ax6AKDmfz1scLAP6vupyYZWgfi77HS78OvY/EHGrrQXI7ls5EK7mZ79f0x
         hyOw==
X-Gm-Message-State: APuU4Z/IYwyoBkMdgCqKgHRMWMJhdXTiZVnsGtgWwuWhFr+cFN7Kf1jo
	4ln9d5vf/iP4HjEA44DQ6oH3aRQ9K9192gykXAIrpYnIZpNeQ853nRLq
X-Gm-Gg: AYBFou0OyaMIt0ZWJBR3GGWQm0L2H2HXOZUnD5XweZZ3gJyKbXx1epLnz/y7U4JeMs7
	HDqYPijESdGfzcJaflUuSMZhEB7vyd/Qf8Rdy9pBymUizw796yUG6pOqKKkAct929vqD77ZMOrR
	gf9k/XFiIYVoiQ51QfeuRiqqc7lQwfjv3LtkRsH3e/T80U/0CwHs5W078TF/NP8AUav83+Rnfau
	VL5bNXxw2NKm+KnLCXHu4nZyLXM/kl4QGm4M9r4gRdaTUtjyfAm7fOPmZBNbkfflo5DTJXO1Txv
	rtXIx+MufHPThKRBsY4B76bP86JKGnCeK5yQwX5ZD2XUpZVTm3zwCbF6w7//4y/DBou3rLltEhM
	apIpURYIDx9YggoCMxCKhH6XnbIi9pv7ac/hBYd7JL6SavTcr//aQHu1td7NlZA606lXPjBqOp9
	zB6cV62xPr+FJUmoPAVClNiIncjuBZbFqtNLNQC2dxle3vH00IqnGc9rfoc3mb5votCmIoDjcNR
	tMSzC/xfkhXvc2qOtOR9VZ7BWC6OkJ2TjPvWLUTMy6Ly4L6/QVbR7y1yjtpTDtjPXoHP2I5Epti
	Ts59s9Zayd8wObd9tEIfIAlBkgSGJbNqSJCK9SQacEJt2I0gSyLqbOxqLWa7gZdJK86iUdx2kHa
	rJ+8HPbFxGXtnzQ94MXSksgeVIacbBmnxC+5I
X-Received: by 2002:ac8:6543:0:b0:536:5a2:76e6 with SMTP id d75a77b69052e-55518dae3e3mr12605211cf.7.1794259437464;
        Mon, 09 Nov 2026 13:23:57 -0800 (PST)
Received: from jkacur-thinkpadp1gen2.rmtcaon.csb ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef0500dffsm5341186d6.28.2026.11.09.13.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:23:56 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	darwi@linutronix.de
Subject: Re: [PATCH v4] rteval: Added multi stressor support
Date: Mon,  9 Nov 2026 16:23:42 -0500
Message-ID: <20261109212342.147143-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <avIUxy2lpHlwtb4L@sansshar-thinkpadp1gen4i.boston.csb>
References: 
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 09 Nov 2026 at 01:45:27PM -0500, Sana Sharma wrote:
> [PATCH v4] rteval: Added multi stressor support

Thanks for the v4, Sana. The warning/log cleanup and the revert back to
print() + sys.exit(1) in validate_stressors() all look good. A few things
still need fixing before this can go in.

1) _WorkloadPrepare() will crash on every run - 'workers' is used before
   it is assigned:

> +        stressors = validate_stressors(self.cfg.stressors)
> +        if workers is not None:
> +            workers = str(self.cfg.workers)  # defaults to '0'
> +        for stressor in stressors:
> +            self.args.extend([f'--{stressor}', workers])

   There is no `workers = self.cfg.workers` before the guard, so
   `if workers is not None:` raises UnboundLocalError (workers is a local,
   only ever assigned inside the if). This fires regardless of the value,
   so the module never runs. It needs to read self.cfg.workers first, e.g.:

        workers = self.cfg.workers
        if workers is not None:
            workers = str(workers)
        for stressor in self.cfg.stressors:
            self.args.append(f'--{stressor}')
            if workers is not None:
                self.args.append(workers)

2) The error message won't parse on Python 3.10/3.11:

> +        print(f"Invalid stress-ng stressor: '{" ".join(invalid)}'. "

   Re-using the same quote character inside an f-string only became legal
   in Python 3.12 (PEP 701). pyproject.toml declares requires-python
   ">=3.10", so on 3.10/3.11 the module fails to import with a SyntaxError.
   Use single quotes inside:

        print(f"Invalid stress-ng stressor: '{' '.join(invalid)}'. "
              "Run 'stress-ng --stressors' to see valid options.")

3) This one is on me - my v3 review asked you to put sys.exit(1) back, but
   that is not actually enough, and it is worth understanding why.

   validate_stressors() is called from _WorkloadPrepare(), which runs on the
   load module's worker thread (rtevalModulePrototype is a threading.Thread
   and _WorkloadPrepare() is reached via run()). sys.exit(1) raises
   SystemExit, but SystemExit is a BaseException, not an Exception, so
   rteval's run() wrapper (except Exception: self._setRuntimeError(); raise)
   never catches it, the runtime-error flag is never set, and threading's
   default excepthook silently ignores SystemExit. The net effect for a bad
   stressor name is that the load thread quietly disappears and rteval runs
   the whole measurement with no load and exits 0 - worse than the v3
   traceback, which was at least visible.

   The fix is to validate on the main thread, before any workload thread
   starts. The natural spot is __init__ (which already reads cfg.stressor /
   cfg.stressors to set _donotrun), where sys.exit(1) actually terminates
   rteval cleanly. Something like:

        if self.cfg.stressors is not None:
            requested = self.cfg.stressors        # comma-separated string
        elif self.cfg.stressor is not None:
            requested = self.cfg.stressor         # list (action='append')
        else:
            requested = None

        if requested is None:
            self._donotrun = True
        else:
            self.cfg.stressors = validate_stressors(requested)
            self._donotrun = False

   Then _WorkloadPrepare() just consumes the already-validated
   self.cfg.stressors list and never needs to validate (or exit) itself.

Minor:

 - Commit subject should be imperative mood: "rteval: Add multi stressor
   support" rather than "Added".

 - Please add a unit test that drives _WorkloadPrepare()'s arg building with
   and without --stressng-workers. The current tests only cover
   validate_stressors(), so the crash in (1) slipped through green. This can
   come as a separate patch.

With 1-3 addressed I think this is in good shape. Thanks again for sticking
with it.

John
