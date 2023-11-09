package com.uor.fot.complainandassetsmanagementsystem.service;

import com.uor.fot.complainandassetsmanagementsystem.model.Asset;
import com.uor.fot.complainandassetsmanagementsystem.repository.AssetRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AssetService {

    private final AssetRepository assetRepository;

    @Autowired
    public AssetService(AssetRepository assetRepository) {
        this.assetRepository = assetRepository;
    }

    public List<Asset> getAllAssets() {
        return assetRepository.findAll();
    }

    public Asset getAssetById(Long id) {
        return assetRepository.getAssetById(id);
    }

    public void saveAsset(Asset asset) {
        assetRepository.save(asset);
    }

    public Asset updateAsset(Long id, Asset updateAsset) {
        Asset updatedAsset = null;
        if (assetRepository.existsById(id)) {
            updateAsset.setId(id);
            updatedAsset = assetRepository.save(updateAsset);
        }
        return updatedAsset;
    }

    public boolean deleteAsset(Long id) {
        if (assetRepository.existsById(id)) {
            assetRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public Asset createAsset(Asset asset) {
        return assetRepository.save(asset);
    }
}
