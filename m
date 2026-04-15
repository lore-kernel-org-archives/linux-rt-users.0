Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F233F8CA
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264488; cv=none; b=LF8wKAgE0RvaEI0V3QFTPri3nx9TalhreB+sdswVCPtK5OGKFbD/eX0GIaBM3DYRJPTXYGgEHZrpst7fEKdZ2or6JXV2Vb0AdTTewFA/pPT9tJat3JieqOZGaoXFFkOBEnl/2jYWT0uCodY9cwP9gHApQARIFYr1BCdh05xvnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264488; c=relaxed/simple;
	bh=o5fW87APlSwwZVMVW0ea8y06A44tbpfrFBXCVR889PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlEqcnOg+uEtVZkOcbUgc/WHtyLFO9SbHW9woiyaEBPfL4h/Bfnj6pMpZMt97s/HWf9m2g5HbJyzGqPlpV6yXD11ThUEZ9N09NZTNBMnoRZC3P62cN31jFxzzYFpHW7wnHFTzbnSedjB5aAprGpPHM/0zULimKEtXamJhSpWFsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lodFjr/q; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lodFjr/q"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso43668666d6.0
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264486; x=1776869286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5fW87APlSwwZVMVW0ea8y06A44tbpfrFBXCVR889PY=;
        b=lodFjr/qg+KPgfzbW9fUycEcq8Nf0uTirSbac68uDuX5n7S8KfWGKh76c/LaAR1ciT
         e86TnATL6lrnwLt6q2CbJPM8uvv04SQC2yNwu6yu7odc1ooOMg12c8ysjfJ7FKsqHdor
         WyINFEBqJmT52U0fznB9QIDITMn4Nn5dIxq8ZzqOFfyXgcO2tmvHVXu3Q9LLY+cj4jo6
         qsYmQRQC8UHJ0Dqfv4T4fUIwjvLCeorpLuuA6/2uLnIz5LmPueTPoXE/ou4WnsanOdtO
         bUmdZJy3UevWsXszwLCAAn5ffzo3ggUAnkQT9b4gLh8Z3HRLjI+XzRgz6uYPU8orNtQy
         TwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264486; x=1776869286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5fW87APlSwwZVMVW0ea8y06A44tbpfrFBXCVR889PY=;
        b=EaiZ/00No3pAaq9MwnFCRqYLWZKBjwX7CM8+mObpZ3VVhi0StaOOGo/kxNVex+nFB/
         VqGiRomqNvpMUsoy8PXkGqTM66Sqoj7dLGu+E39zAImFEEdQb6NGQJ7TS6V5cKUi9COn
         ZX3H5vscIMocEaLLNe4rk9QN7d0mrt01K2KBx5IVKnjPVJ23zLRl6JxUjwG3Su7EIF9R
         bQInAh2XGZKmeu62JWkKTOQAh7aNhf5+bfV5/29Tn/6Hx2roUU2j6InErSLhZ+NVTxwc
         B5HJ7W1F/t3PxA1p6dS97/XdrY5zzZG6Fa0maANdQJbHZEwhNVBhD2jhYeCD5VKEEuBB
         CB3Q==
X-Gm-Message-State: AOJu0YwbNSUIwV3YqmfZBliC17QrFnE3oTfNh0efeoxPWXcXrSVtkXw6
	AbClmUMHKm8ys7/sqQ/joNqmIrpNqOTDHrGtoPR5TG+UyW0tQ85z9sEVIZxP7w==
X-Gm-Gg: AeBDietwvEHR7NlhDrppjG/AvxF17qNqjm8FvhXidIuvsa2jfm5JiwwVSu8AR6uQ/n4
	pMMeOo7XmyxjAVgx7Mik18cpj3qk4hU3PUctbFRQj/3mU6uZlDyxS8TmI/BAWJObyenj1Dd4ruu
	2CUegP/MZKoMk6d6bZqi9cin9r/DwBecXRGT4V6xLogOZaA8fFoKQ1J3ZDUGxVsKSR80vRTgqv+
	xYtl1udmFeyDC5GXva4+O7Wa3PaMHJk4JXrljrA1YPrVTfvS246CN5SSOmhLd5MmgMklDTQu8bu
	Z8rRgrJcYuyim+jRhFrVdEw+zextTha341n6fkEWwQw1/x9+1xtcZ98W8r7uKPIzPXClvd4lwQA
	cJ70VCOjYOgYlNYMQs2o/2LZTiUaNu1Bt4ARaVIwvn0YO0cbyL82I+Ds9f5zYl7rFbo1rbP+D5n
	gW1dvKPotijwLxaSYkX+G9gCG4R8tVSMuGum/Hxbyyz/rjDcwHToRK9l4DVwrFeZ2LuwzgzfpaS
	X+oAP1srVmTINsyirc=
X-Received: by 2002:a0c:f118:0:b0:89a:1575:e1d3 with SMTP id 6a1803df08f44-8ac861b012emr277266536d6.12.1776264485869;
        Wed, 15 Apr 2026 07:48:05 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c938368sm16549656d6.5.2026.04.15.07.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:48:05 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/6] cyclictest: Correctly print clock_nanosleep() errors
Date: Wed, 15 Apr 2026 10:47:50 -0400
Message-ID: <20260415144750.109690-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407-auxclocks-v1-4-1ef80d14eb0a@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Apr 2026 at 08:48:44AM +0200, Thomas Weißschuh (Schneider Electric) wrote:
> cyclictest: Correctly print clock_nanosleep() errors

Applied, thanks!

Signed-off-by: John Kacur <jkacur@redhat.com>
