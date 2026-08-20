Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5201212F89
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Aug 2026 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259112; cv=none; b=FSAHi7qI+VGcv5j6GISToBhfj/pXFGczs0eMwaaF0sGq4j7UbDN4tTpXMerJtPIM3WXLl8yBQruRtdbvtdd+LxuA5k0OqR91Z0nec7crX6AarkYXaJi9pTLE2JiUmfGEigU5hq7bcgFMp726vdCIMVwaXGIKnaiVpEL5nVFMyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259112; c=relaxed/simple;
	bh=JYzseAKIjSjFnyfomLu2m5/YRS1aQqYXrdH7kVgGt+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieieJt7e97kjQkAzdTDho+FezzSXqA4lO4nbUMv2wbUOv86uF/CZXDyQM4Lz0Vm/rE0RWX++hvt0nNUycM0QMrUw0oRCLq8rQtojyiffHmGnMoPbo7FDdlgFjd5vAhi79li2l7VbcPXl+X+l/IBzWGYzFx9+IyTuoMKwug2RwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnO2hQgZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnO2hQgZ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c0ecfaee7so2177981cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Aug 2026 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787259109; x=1787863909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tLN0NkO+tX/60n+sEK+QhDLRRPR4x4ArVPAMwYp+3ls=;
        b=nnO2hQgZ/rfUxgpaBdw5gsFpgVwMayFYujtc4IPFtQcPqpDUo+Mr0iO2pUnJqFeXGq
         rS6dNb5j1M+pt/mCgWyYSXOQCGXr6Fat1DnMDjXR1bCkFqyReCYB6bPS48rOrkc+LTU4
         sM0Qa5d1U8HTc7wLiXtgZ1AGFl3hUQvf/3YwX5+kOx2YYtiz7m6yK6QeK4R3+JfTEXa7
         kHSXuaJMa7itZYmhgciHiZtM6MiE6nCb3GzZyhgassk4hSgMIQAZwgFeEvLikmMZa/9r
         MglB3u1MopCIRHa2fwVqQkp9V2MYc82AFo/U6h6b76cZuLRpxZC9eNK+5K0+IcTMuYS9
         TrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787259109; x=1787863909;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLN0NkO+tX/60n+sEK+QhDLRRPR4x4ArVPAMwYp+3ls=;
        b=dpMkY+vx4ziRBhIUZOreA/aEh1tanw8M1NDBC+gKQ4C574W9ORo9fxlsjo3B63ujxm
         N5sujVbvxr1TTKEAhkbYFaRH6jtlZsLzeuXlQMCIPzo66Y9mHh4yFJMRIx9LOYufjiUJ
         brl8ctSsCmC0CjF2eV+Yhp7r4a5+jROBq7W21qHB2zUtk/ArivjPezfvQicHSaiP6EDI
         qbstdrEy7scoczuJ307DMCCcQzDPrr8qaYB19xySSR1Jb2IKvW+imjSVimcwynaq+Vdp
         Qj6IAwlfe8PzAa7J8Py25j1WMWzkDG/8TV8PsVaG7/HkFgC4xpB5QDEkurFe1XH7lv6s
         hMdg==
X-Gm-Message-State: AOJu0YwC+Kqqn1seVz1tk7B9Pzylqm+51H2ZbxCQkQokEhU1EPA8RGM5
	e73cJ1Fpa4oehILRekUYJzFx5l3I3uebzlRPQp9GbDt885cwK8XiOLlr6/HtMg==
X-Gm-Gg: AR+sD13FHJhS5yNIxf+Bgna531bI8NPN1Osottr/E234sa0Z6chTKYwrjhXr6+Bu7Qe
	6jIQ5pHydToSmw7ZgEMKVQCwIF1ISQSC7EGptyqwJKffrWEu9hvUND57HJIdqP2EGzBEm/o1bTv
	GSOiP8QfIIdQCl1RXQDQx7n0+9rSEsByyvtqBh4Go+FuSQFUDdvxwUdDoBvCQTVcxhtKZL27brU
	ZALNZ59JYyeaviI8sZy7UOvKu0M3Q/ShT3maF2cQ3/7a5L2j7A31RhU70n7v47/Ic6wrmmM5OMm
	30uLgP3mFS0F+UeeNwT+qdqgNYmo55lRBXTUOvkxnLQkKhDZaa5V2QghgcNRLFB/BZw+9BO2ozb
	Iif8tQ0GiEfXWiEeMnKlbLXiXgg9nyj+atiA+Lu+7OEpbTZdLnVq/QxJIKrAfwWPuxCuZf9XmCt
	dWaJH6e0fxfQrtxySS+bmh62e/xg15h/L2fkvQXZEGPkH4d96Mvv9bMbyJjS6Ax+dKun7n27O22
	Q77cKEB7LDSv3qg4fjIXVn7Oe7CLtq6OKoD5ipHPbSIepuF9lhX8n+i
X-Received: by 2002:a05:622a:1f96:b0:51c:94f:8ce with SMTP id d75a77b69052e-52df5a07071mr13550561cf.34.1787259109452;
        Thu, 20 Aug 2026 13:51:49 -0700 (PDT)
Received: from Cumhall.redhat.corp ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52df42408ebsm5546881cf.21.2026.08.20.13.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 13:51:48 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] Adding stressor validation for stress-ng
Date: Thu, 20 Aug 2026 16:51:34 -0400
Message-ID: <20260820205134.147588-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820135803.385563-1-sansshar@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sana,

I have one suggestion about error handling:

**Issue: Silent failure when stress-ng is not installed**

In `get_valid_stressors()`, when stress-ng is not found, the function returns an empty list:

```python
except (subprocess.CalledProcessError, FileNotFoundError):
    return []
```

Then in `validate_stressor()`, this empty list causes validation to silently pass:

```python
if not valid:
    return  # Allows any stressor name through
```

**Suggested fix:**

```python
def get_valid_stressors():
    """Query stress-ng for list of valid stressor names."""
    try:
        result = subprocess.run(['stress-ng', '--stressors'],
                                capture_output=True, text=True, check=True)
        return result.stdout.strip().split()
    except FileNotFoundError:
        print("stress-ng is not installed. Please install the stress-ng package.")
        sys.exit(1)
    except subprocess.CalledProcessError as e:
        print(f"Failed to query stress-ng stressors: {e}")
        sys.exit(1)
```

This follows the pattern used in rteval/cpupower.py and gives users a clear error message during `_WorkloadPrepare()` instead of a cryptic failure later.

Thanks
John Kacur
