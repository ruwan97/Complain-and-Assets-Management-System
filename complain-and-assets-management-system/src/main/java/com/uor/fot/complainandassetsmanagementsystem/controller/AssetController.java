package com.uor.fot.complainandassetsmanagementsystem.controller;

import com.uor.fot.complainandassetsmanagementsystem.model.Asset;
import com.uor.fot.complainandassetsmanagementsystem.service.AssetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/assets")
public class AssetController {

    private final AssetService assetService;

    @Autowired
    public AssetController(AssetService assetService) {
        this.assetService = assetService;
    }

    @PostMapping
    public ResponseEntity<Asset> createAsset(@RequestBody Asset asset) {
        Asset createdAsset = assetService.createAsset(asset);
        return new ResponseEntity<>(createdAsset, HttpStatus.CREATED);
    }

    @GetMapping
    public String showAllAssets(Model model) {
        List<Asset> assets = assetService.getAllAssets();
        model.addAttribute("assets", assets);
        return "assets";
    }

    @GetMapping("/new")
    public String showAssetForm(Model model) {
        model.addAttribute("asset", new Asset());
        return "asset-form";
    }

    @GetMapping("/{id}")
    public String showAssetById(@PathVariable Long id, Model model) {
        Asset asset = assetService.getAssetById(id);
        model.addAttribute("asset", asset);
        return "asset-form";
    }

    @PutMapping("/{id}")
    public ResponseEntity<Asset> updateAsset(@PathVariable Long id, @RequestBody Asset updatedAsset) {
        Asset asset = assetService.updateAsset(id, updatedAsset);
        if (asset != null) {
            return new ResponseEntity<>(asset, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAsset(@PathVariable Long id) {
        boolean deleted = assetService.deleteAsset(id);
        if (deleted) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
